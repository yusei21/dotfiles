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

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})
