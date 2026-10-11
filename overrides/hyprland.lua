-- Personalizacoes sobre HyDE (carregado antes deste arquivo).
-- Monitores originais do repositorio yusei21/dotfiles:
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@119.98", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@239.96", position = "1920x0", scale = 1 })

hl.config({ xwayland = { force_zero_scaling = true } })

-- Mesmas teclas da configuracao anterior; terminal Kitty.
-- HyDE tem deduplicacao de atalhos habilitada na configuracao padrao.
hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"), {
  description = "[Launcher|Apps] terminal emulator",
})
hl.bind("SUPER + Q", hl.dsp.window.close(), {
  description = "[Windows] close active window",
})
