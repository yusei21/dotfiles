hl.config({
  decoration = {
    rounding = 10,
    rounding_power = 2.2,
    active_opacity = 1.0,
    inactive_opacity = 0.96,

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      ignore_opacity = true,
      popups = true,
      new_optimizations = true,
      noise = 0.015,
      contrast = 0.96,
      brightness = 0.92,
      vibrancy = 0.12,
    },

    shadow = {
      enabled = true,
      range = 14,
      render_power = 3,
      color = "rgba(00000066)",
    },
  },
})
