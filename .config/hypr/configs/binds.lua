local apps = require("configs.default_apps")
local mainMod = "SUPER"

local function bind(keys, dispatcher, description, flags)
  flags = flags or {}
  flags.description = description
  hl.bind(keys, dispatcher, flags)
end

-- Wallpaper and media.
bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_select.sh"), "Choose wallpaper")
bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/random_wallpaper.sh"), "Next wallpaper")
bind(mainMod .. " + M", hl.dsp.exec_cmd(apps.music), "Open Spotify")

-- Applications.
bind(mainMod .. " + C", hl.dsp.exec_cmd(apps.ide), "Open IDE")
bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"), "Open Vesktop")
bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"), "Open file manager")
bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/recorder.sh"), "Toggle screen recording")
bind(mainMod .. " + T", hl.dsp.exec_cmd(apps.terminal), "Open terminal")
bind(mainMod .. " + W", hl.dsp.exec_cmd(apps.browser), "Open browser")
bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps.menu), "Open application launcher")
bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(apps.terminal), "Open terminal")

bind(
  mainMod .. " + SHIFT + RETURN",
  hl.dsp.exec_cmd(apps.terminal, {
    float = true,
    center = true,
    size = { "monitor_w * 0.45", "monitor_h * 0.50" },
  }),
  "Open floating terminal"
)

-- Window controls.
bind(mainMod .. " + Q", hl.dsp.window.close({}), "Close active window")
bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), "Toggle fullscreen")
bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), "Toggle floating")
bind(mainMod .. " + SHIFT + C", hl.dsp.window.center({}), "Center active window")
bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }), "Toggle pseudotile")
bind(mainMod .. " + L", hl.dsp.exec_cmd(apps.lockscreen), "Lock session")
bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprshutdown"), "Exit Hyprland")
bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprshutdown"), "Exit Hyprland")

-- Focus.
bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }), "Focus left")
bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }), "Focus right")
bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }), "Focus up")
bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }), "Focus down")

-- Move windows.
bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }), "Move window left")
bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), "Move window right")
bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), "Move window up")
bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }), "Move window down")

-- Resize windows.
bind("CTRL + " .. mainMod .. " + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), "Grow window right", { repeating = true })
bind("CTRL + " .. mainMod .. " + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), "Shrink window right", { repeating = true })
bind("CTRL + " .. mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), "Grow window down", { repeating = true })
bind("CTRL + " .. mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), "Shrink window down", { repeating = true })

-- Mouse.
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), "Move window with mouse", { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), "Resize window with mouse", { mouse = true })

-- Workspaces.
for i = 1, 10 do
  local key = i == 10 and "0" or tostring(i)
  bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }), "Go to workspace " .. i)
  bind(
    mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = tostring(i), follow = true }),
    "Move window to workspace " .. i
  )
end

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")
bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")

-- Screenshots.
bind("Print", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"), "Capture monitor")
bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"), "Capture region")
bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"), "Capture window")
bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"), "Capture region")

-- Audio.
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --inc"), "Volume up", { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --dec"), "Volume down", { locked = true, repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --toggle"), "Toggle mute", { locked = true })

-- Brightness.
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --inc"), "Brightness up", { repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --dec"), "Brightness down", { repeating = true })

-- System utilities.
bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("~/.config/waybar/script/waybar_restart.sh"), "Restart Waybar")
bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), "Reload Hyprland")
bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("~/.config/rofi/assets/clipManager.sh"), "Open clipboard manager")

-- Passthrough submap.
bind(mainMod .. " + X", hl.dsp.submap("passthru"), "Enter passthrough mode")

hl.define_submap("passthru", function()
  bind(mainMod .. " + Escape", hl.dsp.submap("reset"), "Leave passthrough mode")
end)
