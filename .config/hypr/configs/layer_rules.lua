local function clean_layer(namespace, animation)
  hl.layer_rule({
    match = {
      namespace = namespace,
    },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.18,
    animation = animation,
  })
end

clean_layer("waybar", "fade")
clean_layer("rofi", "popin 92%")
clean_layer("swaync-control-center", "popin 94%")
clean_layer("swaync-notification-window", "slide")
