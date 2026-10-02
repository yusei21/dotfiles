-- Hyprland Lua configuration
-- Migrated from the legacy .conf configuration for Hyprland 0.55+.
-- The old .conf files are intentionally kept in the repository as a rollback reference.

local mainMod = "SUPER"
local browser = "brave"
local terminal = "kitty"
local menu = "rofi -show drun"
local lockscreen = "hyprlock"
local music = "spotify --ozone-platform=wayland"
local ide = "antigravity-ide"

-- Monitors
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@119.98",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-3",
    mode = "1920x1080@239.96",
    position = "1920x0",
    scale = 1,
})

-- Environment
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Core settings
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        kb_layout = "us",
        kb_options = "caps:escape",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in = 10,
        gaps_out = 20,
        border_size = 1,
        col = {
            active_border = "rgba(262626aa)",
            inactive_border = "rgba(111111aa)",
        },
        layout = "dwindle",
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    },

    decoration = {
        rounding = 6,
        active_opacity = 1.0,
        inactive_opacity = 0.9,

        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            ignore_opacity = true,
            popups = true,
            new_optimizations = true,
            noise = 0.0200,
            contrast = 1.0,
            brightness = 0.8172,
            vibrancy = 0.1696,
        },

        shadow = {
            enabled = true,
            range = 20,
            render_power = 4,
            color = "rgba(000000b3)",
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },
})

-- Curves and animations
hl.curve("wind", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})
hl.curve("winIn", {
    type = "bezier",
    points = { { 0.1, 1.1 }, { 0.1, 1.1 } },
})
hl.curve("winOut", {
    type = "bezier",
    points = { { 0.3, -0.3 }, { 0, 1 } },
})
hl.curve("liner", {
    type = "bezier",
    points = { { 1, 1 }, { 1, 1 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

-- Autostart. hyprland.start is the Lua equivalent of keeping these launch-only.
hl.on("hyprland.start", function()
    hl.exec_cmd("pkill mako")
    hl.exec_cmd("pkill dunst")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("test -f ~/.cache/wal/colors.sh && wal -R")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync -c ~/.config/swaync/config.json -s ~/.config/swaync/style.css")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- Wallpaper / media
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_select.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/random_wallpaper.sh"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(music))

-- Applications
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ide))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/recorder.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("con"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminal, {
    float = true,
    size = { "45%", "50%" },
    center = true,
}))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.center())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lockscreen))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exit())

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Resize windows
hl.bind("CTRL + " .. mainMod .. " + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind("CTRL + " .. mainMod .. " + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind("CTRL + " .. mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind("CTRL + " .. mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({
        workspace = tostring(i),
        follow = true,
    }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("CTRL + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --inc"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --dec"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --toggle"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --inc"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --dec"))

-- System
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("~/.config/waybar/script/waybar_restart.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("~/.config/rofi/assets/clipManager.sh"))

-- Passthrough submap
hl.bind(mainMod .. " + X", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function()
    hl.bind("SUPER + Escape", hl.dsp.submap("reset"))
end)

-- Window rules and layer rules remain intentionally disabled, matching the
-- current legacy config where they are commented out for compatibility.
