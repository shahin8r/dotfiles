#!/bin/bash

if [ -f "/tmp/screen_awake" ]; then
  exit 0
fi

if [ -z "$XSS_SLEEP_LOCK_FD" ]; then
  notify-send 'Locking screen in 15s'
  sleep 15s

  if [ -f "/tmp/screen_awake" ]; then
    exit 0
  fi
fi

dunst set-paused true

img=$(mktemp /tmp/XXXXXXXXXX.png)
import -window root $img 
convert $img -scale 10% -scale 1000% $img

i3lock -n -u -i $img
rm $img

dunst set-paused false
