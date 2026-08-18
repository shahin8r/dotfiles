#!/bin/bash

set -euo pipefail

function log () {
  echo -e "\n---------------------"
  echo "$1..."
  echo -e "---------------------\n"
}

if [[ ! -f /etc/arch-release ]]; then
  echo "This installer expects Arch Linux."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman is required."
  exit 1
fi

if [[ -e "$HOME/.dotfiles" ]]; then
  echo "$HOME/.dotfiles already exists."
  exit 1
fi

pacman_packages=(
  git
  openssh
  man-db
  zsh
  aws-cli
  curl
  neovim
  vim
  nodejs
  npm
  tmux
  pv
  htop
  jq
  mpv
  ranger
  screen
  ncdu
  telegram-desktop
  nload
  transmission-gtk
  mariadb-clients
  peco
  feh
  ripgrep
  fzf
  playerctl
  bat
  python-pip
  iwd
  impala
  imagemagick
  wget
  libnotify
  yarn
  rsync
  unzip
  fd
  polkit
  bind
  noto-fonts-emoji
  zip
  eza
  wiremix
  pamixer
  wl-clipboard
  base-devel
  code
  docker
  docker-compose
  terraform
  aws-vault
  packer
  gnome-themes-extra
  alacritty
  github-cli
  openai-codex
  bluez
  bluez-utils
  ttf-jetbrains-mono-nerd
  gnome-keyring
  seahorse
  hyprland
  hyprlock
  hypridle
  hyprpaper
  hyprshot
  hyprpicker
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  swayosd
  swaync
  brightnessctl
  bluetui
  udiskie
  waybar
  nwg-look
  btop
  nautilus
  xdg-user-dirs
)

aur_packages=(
  1password
  google-chrome
  brave-bin
  slack-desktop
  spotify
  beekeeper-studio
  walker
  elephant-desktopapplications
  elephant-calc
  elephant-clipboard
  elephant-providerlist
  elephant-symbols
  elephant-files
  terminaltexteffects-git
)

log 'install pacman packages'
sudo pacman -Syu --needed --noconfirm "${pacman_packages[@]}"

log 'clone dotfiles'
git clone https://github.com/shahin8r/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
git remote set-url origin git@github.com:shahin8r/dotfiles.git

log 'install yay'
if ! command -v yay >/dev/null 2>&1; then
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  cd "$tmpdir/yay"
  makepkg -si --needed --noconfirm
  cd "$HOME/.dotfiles"
fi

log 'install aur packages'
yay -S --needed --noconfirm --answerdiff=None "${aur_packages[@]}"

log 'setup config directories'
mkdir -p "$HOME/.config"

log 'setup dotfile symlinks'
ln -sf "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$HOME/.dotfiles/.gitignore" "$HOME/.gitignore"
ln -sf "$HOME/.dotfiles/bin" "$HOME/bin"
ln -sf "$HOME/.dotfiles/alacritty.toml" "$HOME/.config/alacritty.toml"
ln -sfn "$HOME/.dotfiles/xdg-desktop-portal" "$HOME/.config/xdg-desktop-portal"
ln -sfn "$HOME/.dotfiles/hypr" "$HOME/.config/hypr"
ln -sfn "$HOME/.dotfiles/waybar" "$HOME/.config/waybar"
ln -sfn "$HOME/.dotfiles/swaync" "$HOME/.config/swaync"
ln -sfn "$HOME/.dotfiles/walker" "$HOME/.config/walker"
ln -sfn "$HOME/.dotfiles/btop" "$HOME/.config/btop"

log 'install nvm'
if [[ ! -d "$HOME/.nvm" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
fi

log 'install oh-my-zsh and plugins'
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$zsh_custom/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$zsh_custom/themes/powerlevel10k"
fi

log 'set zsh to default shell'
sudo chsh -s "$(which zsh)" "$USER"

log 'generate ssh key'
if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
  ssh-keygen -t ed25519 -C "shahin.ag@gmail.com"
fi

log 'setup user directories'
xdg-user-dirs-update

log 'enable services'
sudo systemctl enable bluetooth
sudo systemctl enable iwd
sudo systemctl enable docker
sudo usermod -aG docker "$USER"

log 'All done! Reboot, then add the SSH key to GitHub and sign in to 1Password.'
