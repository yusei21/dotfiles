#!/usr/bin/env bash
set -u
for cmd in Hyprland hyprpaper ghostty fish nvim fuzzel waybar docker ollama nvidia-smi; do
  if command -v "$cmd" >/dev/null 2>&1; then printf 'OK   %s\n' "$cmd"; else printf 'MISS %s\n' "$cmd"; fi
done
if command -v hyprctl >/dev/null 2>&1; then
  echo "-- Hyprland --"
  hyprctl version 2>/dev/null | head -n 5 || true
  hyprctl monitors all 2>/dev/null | grep -E "Monitor |[0-9]+x[0-9]+@[0-9.]+" || true
  hyprctl configerrors 2>/dev/null || true
fi
if [[ -r /sys/module/nvidia_drm/parameters/modeset ]]; then
  printf 'NVIDIA DRM modeset: %s\n' "$(cat /sys/module/nvidia_drm/parameters/modeset)"
fi
if command -v nvidia-smi >/dev/null 2>&1; then nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader || true; fi
