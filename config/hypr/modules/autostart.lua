hl.on("hyprland.start",function()
    for _,cmd in ipairs({"waybar","hyprpaper","hypridle","mako","wl-paste --watch cliphist store","sleep 1; ~/.local/bin/dot-wall horizontal restore; ~/.local/bin/dot-wall vertical restore"}) do
        hl.dispatch(hl.dsp.exec_cmd(cmd))
    end
end)
