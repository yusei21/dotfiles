#!/usr/bin/env bash

THEME_FILE="/tmp/theme_variant"
wal_arguments=""

if [ -s "$THEME_FILE" ]; then
  case $(<"$THEME_FILE") in
    "light") wal_arguments="lighten -l" ;;
  esac
fi

wallpaper="$HOME/wallpaper/wallpaper.png"

if [ ! -f "$wallpaper" ]; then
  notify-send -a "theme" "No wallpaper found" "$wallpaper"
  exit 1
fi

if ! command -v wal >/dev/null 2>&1; then
  notify-send -a "theme" "pywal is not installed"
  exit 1
fi

wal -i "$wallpaper" --cols16 $wal_arguments -q -n -e

if pgrep -x "waybar" >/dev/null; then
    killall waybar
fi

if command -v waybar >/dev/null 2>&1; then
  waybar &
fi

command -v swaync-client >/dev/null 2>&1 && swaync-client -rs
command -v pywalfox >/dev/null 2>&1 && pywalfox update
