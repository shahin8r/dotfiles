#!/bin/bash

# Relaunch inside a fullscreen Alacritty instance if we're not already there.
if [[ -z "${SCREENSAVER_CHILD:-}" ]]; then
  # Bail if Hyprlock already owns the session or the saver is running.
  if pidof hyprlock || pgrep -f "alacritty --class Screensaver"; then
    exit 0
  fi

  SCRIPT_PATH="$(realpath "$0")"
  exec alacritty --class Screensaver --title Screensaver \
    -o window.padding.x=0 \
    -o window.padding.y=0 \
    -o colors.primary.background="'#000000'" \
    -o window.opacity=1 \
    -o colors.cursor.cursor="'#000000'" \
    -e env SCREENSAVER_CHILD=1 "$SCRIPT_PATH"
fi

screensaver_in_focus() {
  hyprctl activewindow -j | jq -e '.class == "Screensaver"' >/dev/null 2>&1
}

exit_screensaver() {
  tput cnorm 2>/dev/null
  pkill -x tte 2>/dev/null
  pkill -f "alacritty --class Screensaver" 2>/dev/null
  exit 0
}

trap exit_screensaver SIGINT SIGTERM SIGHUP SIGQUIT

tput civis 2>/dev/null

while true; do
  tte -i ~/.dotfiles/logo.txt \
    --frame-rate 240 --canvas-width 0 --canvas-height $(($(tput lines) - 2)) --anchor-canvas c --anchor-text c \
    --random-effect &

  while pgrep -x tte >/dev/null; do
    if read -n 1 -t 3 || ! screensaver_in_focus; then
      exit_screensaver
    fi
  done
done
