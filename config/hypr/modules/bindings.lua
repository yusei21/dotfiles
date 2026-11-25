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
run("SUPER + SHIFT + S","grim -g \"$(slurp)\" - | wl-copy")
run("SUPER + V","cliphist list | fuzzel --dmenu | cliphist decode | wl-copy")
for key,dir in pairs({Left="l",Right="r",Up="u",Down="d"}) do
    hl.bind("SUPER + "..key,hl.dsp.focus({direction=dir}))
end
for i=1,10 do
    hl.bind("SUPER + "..(i%10),hl.dsp.focus({workspace=tostring(i)}))
end
local reduced=false
hl.bind("SUPER + G",function()
    reduced=not reduced
    hl.config({decoration={blur={enabled=not reduced}},animations={enabled=not reduced}})
end)
