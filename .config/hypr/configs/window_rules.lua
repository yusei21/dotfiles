-- Keep modal dialogs compact and visually separated from tiled content.
hl.window_rule({
  name = "center-modal-dialogs",
  match = {
    modal = true,
  },
  float = true,
  center = true,
  rounding = 10,
})
