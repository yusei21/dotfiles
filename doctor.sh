#!/usr/bin/env bash
set -u
for cmd in Hyprland hyprctl hyprpaper waybar kitty nvim matugen fish fuzzel; do command -v "$cmd" || printf 'Missing: %s\n' "$cmd"; done
if [[ -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]]; then hyprctl configerrors; hyprctl monitors; fi
