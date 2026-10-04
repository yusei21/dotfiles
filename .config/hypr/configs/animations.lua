hl.curve("snappy", {
  type = "bezier",
  points = {
    { 0.20, 0.90 },
    { 0.20, 1.00 },
  },
})

hl.curve("smooth", {
  type = "bezier",
  points = {
    { 0.25, 0.10 },
    { 0.25, 1.00 },
  },
})

hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "snappy", style = "popin 94%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.0, bezier = "snappy", style = "popin 94%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "smooth", style = "popin 96%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4.0, bezier = "smooth" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "smooth", style = "slidefade 18%" })
hl.animation({ leaf = "layers", enabled = true, speed = 4.0, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "border", enabled = true, speed = 3.0, bezier = "smooth" })
