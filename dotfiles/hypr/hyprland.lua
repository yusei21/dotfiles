-- Hyprland 0.55+ · CachyOS · NVIDIA · clean monochrome
-- Configuração em Lua; workspaces dinâmicos, sem fixar monitor.
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@119.98", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@239.96", position = "1920x0", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "intl",
    follow_mouse = 1,
    touchpad = { natural_scroll = true },
  },
  general = {
    layout = "dwindle",
    gaps_in = 5,
    gaps_out = 9,
    border_size = 1,
    col = {
      active_border = "rgba(80858dff)",
      inactive_border = "rgba(32363dff)",
    },
    resize_on_border = true,
  },
  decoration = {
    rounding = 7,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = { enabled = false },
    blur = { enabled = false },
  },
  animations = { enabled = false },
  dwindle = { pseudotile = true, preserve_split = true },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },
})

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("mako")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

hl.bind("SUPER + T", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("sh -c 'command -v brave-origin >/dev/null && exec brave-origin || exec brave-origin-browser'"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("librewolf"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("ghostty -e yazi"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + SHIFT + DELETE", hl.dsp.exec_cmd("dolphin trash:/"))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("sh -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'"))
hl.bind("SUPER + Q", hl.dsp.window.close({}))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy --type image/png'))

for _, entry in ipairs({
  { key = "LEFT", direction = "l" },
  { key = "DOWN", direction = "d" },
  { key = "UP", direction = "u" },
  { key = "RIGHT", direction = "r" },
}) do
  hl.bind("SUPER + " .. entry.key, hl.dsp.focus({ direction = entry.direction }))
  hl.bind("SUPER + SHIFT + " .. entry.key, hl.dsp.window.move({ direction = entry.direction }))
end

for number = 1, 9 do
  hl.bind("SUPER + " .. number, hl.dsp.focus({ workspace = number }))
  hl.bind("SUPER + SHIFT + " .. number, hl.dsp.window.move({ workspace = number }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
