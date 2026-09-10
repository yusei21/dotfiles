#!/usr/bin/env bash

ICON_PATH="$HOME/.config/hypr/scripts/icons"
BATTERY_PATH="${BATTERY_PATH:-/sys/class/power_supply/BAT0}"

if [ ! -r "$BATTERY_PATH/capacity" ] || [ ! -r "$BATTERY_PATH/status" ]; then
    notify-send -u low -i "$ICON_PATH/battery-unplugged.png" "Battery monitor disabled" "No readable battery found at $BATTERY_PATH."
    exit 0
fi

check_battery_status() {
    local capacity status
    capacity=$(<"$BATTERY_PATH/capacity")
    status=$(<"$BATTERY_PATH/status")

    if [ "$capacity" -le 20 ] && [ "$previous_status" != "low" ]; then
         notify-send -u critical -i "$ICON_PATH/battery-low.png" "Battery at 20%" "Please plug in your charger."
        previous_status="low"
    elif [ "$capacity" -eq 100 ] && [ "$previous_status" != "full" ]; then
         notify-send -u normal -i "$ICON_PATH/battery-full.png" "Battery at 100%" "Your battery is fully charged. You can unplug your device."
        previous_status="full"
    fi

    if [ "$status" == "Charging" ] && [ "$previous_power_status" != "plugged" ]; then
        notify-send -u normal -i "$ICON_PATH/battery-charging.png" "Charging" "Charger is plugged in."
        previous_power_status="plugged"
    elif [ "$status" == "Discharging" ] && [ "$previous_power_status" != "unplugged" ]; then
        notify-send -u normal -i "$ICON_PATH/battery-unplugged.png" "Discharging" "Charger is unplugged."
        previous_power_status="unplugged"
    fi
}

# Initialize previous states
previous_status=""
previous_power_status=""

while true; do
    check_battery_status
    sleep 60
done
