local function run(key, command)
    hl.bind(key, hl.dsp.exec_cmd(command))
end
run("SUPER + T","kitty")
run("SUPER + W","brave-origin")
run("SUPER + SHIFT + W","librewolf")
run("SUPER + E","dolphin")
run("SUPER + D","fuzzel")
run("SUPER + L","hyprlock")
run("SUPER + Return","~/.local/bin/dot-wall horizontal next")
run("SUPER + SHIFT + Return","~/.local/bin/dot-wall horizontal select")
run("SUPER + ALT + Return","~/.local/bin/dot-wall vertical next")
run("SUPER + ALT + SHIFT + Return","~/.local/bin/dot-wall vertical select")
run("SUPER + SHIFT + S","~/.local/bin/dot-shot region")
run("SUPER + CTRL + S","~/.local/bin/dot-shot monitor")
run("SUPER + V","cliphist list | fuzzel --dmenu | cliphist decode | wl-copy")
hl.bind("SUPER + Q",hl.dsp.window.close())
hl.bind("SUPER + F",hl.dsp.window.fullscreen({mode="fullscreen"}))
hl.bind("SUPER + SHIFT + F",hl.dsp.window.float({action="toggle"}))
for key,d in pairs({Left={"l",-40,0},Right={"r",40,0},Up={"u",0,-40},Down={"d",0,40}}) do
    hl.bind("SUPER + "..key,hl.dsp.focus({direction=d[1]}))
    hl.bind("SUPER + SHIFT + "..key,hl.dsp.window.move({direction=d[1]}))
    hl.bind("SUPER + CTRL + "..key,hl.dsp.window.resize({x=d[2],y=d[3],relative=true}))
end
for i=1,10 do
    hl.bind("SUPER + "..(i%10),hl.dsp.focus({workspace=tostring(i)}))
    hl.bind("SUPER + SHIFT + "..(i%10),hl.dsp.window.move({workspace=tostring(i)}))
end
run("SUPER + G","~/.local/bin/dot-performance")
run("XF86AudioRaiseVolume","wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")
run("XF86AudioLowerVolume","wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
run("XF86AudioMute","wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
run("XF86AudioPlay","playerctl play-pause")
run("SUPER + Escape","~/.local/bin/dot-session")

-- Classic mouse-driven movement and resizing.
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
