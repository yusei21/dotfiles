hl.on("hyprland.start", function()
  -- Kill conflicting notification daemons.
  hl.exec_cmd("pkill mako")
  hl.exec_cmd("pkill dunst")

  -- Wallpaper backend.
  hl.exec_cmd("awww-daemon")

  -- Restore Pywal colors if available.
  hl.exec_cmd("test -f ~/.cache/wal/colors.sh && wal -R")

  -- Bars and notifications.
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync -c ~/.config/swaync/config.json -s ~/.config/swaync/style.css")

  -- Idle / lock.
  hl.exec_cmd("hypridle")

  -- Clipboard history.
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
