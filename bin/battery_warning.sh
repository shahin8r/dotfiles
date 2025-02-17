#!/bin/bash

if pidof -x "$(basename "$0")" -o $$ > /dev/null; then
  exit 0
fi

low_battery_warning=10
critical_battery_warning=5
suspend_battery=3

notified_file="/tmp/battery_last_notified"
last_notified_level=$([[ -s "$notified_file" ]] && cat "$notified_file" || echo -1)

send_notification() {
  local title="$1"
  local message="$2"
  local urgency="$3"
  local level="$4"

  if [[ "$last_notified_level" -ne "$level" ]]; then
    notify-send "$title" "$message" -u "$urgency"
    echo "$level" > "$notified_file"
  fi
}

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

if [[ "$battery_status" != "Discharging" ]]; then
  exit 0
fi

if [[ "$battery_level" -eq $low_battery_warning ]]; then
    send_notification "⚠ Low Battery" "Battery at $battery_level%! Plug in charger!" "critical" "$battery_level"
fi

if [[ "$battery_level" -le $critical_battery_warning ]]; then
    send_notification "🔥 CRITICAL BATTERY" "Battery at $battery_level%! PLUG IN NOW OR SHUTDOWN IMMINENT!" "critical" "$battery_level"
fi

if [[ "$battery_level" -le $suspend_battery ]]; then
    systemctl suspend
fi


