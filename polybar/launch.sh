#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini

if type "xrandr"; then
  for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$monitor polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown
  done
else
  polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown
fi

echo "Polybar launched..."
