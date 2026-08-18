#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
THEMES_DIR="$DOTFILES/themes"
CURRENT_LINK="$THEMES_DIR/current"
STATE_FILE="${DOTFILES_THEME_STATE:-$DOTFILES/.theme-mode}"

mkdir -p "$(dirname "$STATE_FILE")"

current_mode="$(cat "$STATE_FILE" 2>/dev/null || echo dark)"

if [[ "$current_mode" == "dark" ]]; then
  next_mode="light"
  gtk_theme="Adwaita"
  color_scheme="prefer-light"
  wallpaper="$DOTFILES/wallpaper.jpg"
  btop_theme="current"
else
  next_mode="dark"
  gtk_theme="Adwaita-dark"
  color_scheme="prefer-dark"
  wallpaper="$DOTFILES/wallpaper.png"
  btop_theme="Default"
fi

ln -sfn "$THEMES_DIR/$next_mode" "$CURRENT_LINK"
mkdir -p "$DOTFILES/btop/themes"
sed -i "s/^color_theme = .*/color_theme = \"$btop_theme\"/" "$DOTFILES/btop/btop.conf"
if [[ -f "$CURRENT_LINK/btop.theme" ]]; then
  ln -sfn "$CURRENT_LINK/btop.theme" "$DOTFILES/btop/themes/current.theme"
fi
if [[ -d "$HOME/.config/btop" ]]; then
  mkdir -p "$HOME/.config/btop/themes"
  sed -i "s/^color_theme = .*/color_theme = \"$btop_theme\"/" "$HOME/.config/btop/btop.conf"
  if [[ -f "$CURRENT_LINK/btop.theme" ]]; then
    ln -sfn "$CURRENT_LINK/btop.theme" "$HOME/.config/btop/themes/current.theme"
  fi
fi
echo "$next_mode" > "$STATE_FILE"
touch "$DOTFILES/alacritty.toml"

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface color-scheme "$color_scheme" >/dev/null 2>&1 || true
  gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme" >/dev/null 2>&1 || true
fi

if command -v hyprctl >/dev/null 2>&1 && pgrep -x hyprpaper >/dev/null 2>&1; then
  hyprctl hyprpaper reload ,"$wallpaper" >/dev/null 2>&1 || true
fi

pkill -SIGUSR2 waybar >/dev/null 2>&1 || true
timeout 1s swaync-client --reload-css >/dev/null 2>&1 || true
tmux source-file "$CURRENT_LINK/tmux.conf" >/dev/null 2>&1 || true

timeout 1s notify-send "Theme" "Switched to $next_mode mode" >/dev/null 2>&1 || true
