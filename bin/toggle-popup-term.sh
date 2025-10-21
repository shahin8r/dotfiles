#!/bin/bash
APP_ID="popup-term"

CMD="$*"

if hyprctl clients | grep -q "class: $APP_ID"; then
  hyprctl dispatch killwindow "class:$APP_ID"
fi

alacritty --class "$APP_ID" -e bash -c "$CMD"

