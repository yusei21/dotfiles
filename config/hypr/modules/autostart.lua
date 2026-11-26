hl.on("hyprland.start",function()
    for _,cmd in ipairs({"waybar","hyprpaper","hypridle","mako","systemctl --user start hyprpolkitagent.service","wl-paste --watch cliphist store","~/.local/bin/dot-wall horizontal restore & ~/.local/bin/dot-wall vertical restore & wait"}) do
        hl.dispatch(hl.dsp.exec_cmd(cmd))
    end
end)
