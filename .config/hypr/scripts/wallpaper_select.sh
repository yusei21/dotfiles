#!/usr/bin/env bash

image_dir="$HOME/wallpaper/"
mapfile -t images < <(find "$image_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)

if ((${#images[@]} == 0)); then
    notify-send -a "Wallpaper selector" "No wallpapers found" "$image_dir"
    exit 1
fi

image_list=""
for img in "${images[@]}"; do
    name="$(basename "$img")"
    image_list+="${name%.*}\x00icon\x1f${img}\n"
done

selected_image=$(printf '%b' "$image_list" | rofi -dmenu -theme ~/.config/rofi/wallpaper-select.rasi -p "Select wallpaper")

for img in "${images[@]}"; do
    name="$(basename "$img")"
    if [[ "${name%.*}" = "$selected_image" ]]; then
        selected_image_path="$img"
        break
    fi
done

if [ -n "$selected_image_path" ]; then
  ln -sf "$selected_image_path" "$HOME/wallpaper/wallpaper.png"

  if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    bash "$HOME/.config/hypr/scripts/set_wallpaper.sh"
  else
    i3-msg restart
  fi

  notify-send -a "Wallpaper selector" "Wallpaper changed" "$selected_image_path" -i "$HOME/wallpaper/wallpaper.png"
  bash "$HOME/.config/hypr/scripts/apply_wal_theme.sh"
fi
