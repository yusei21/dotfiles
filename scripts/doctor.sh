#!/usr/bin/env bash
set -u
for cmd in Hyprland ghostty fish nvim firefox fuzzel waybar docker ollama nvidia-smi; do
  if command -v "$cmd" >/dev/null 2>&1; then printf 'OK   %s\n' "$cmd"; else printf 'MISS %s\n' "$cmd"; fi
done
if [[ -r /sys/module/nvidia_drm/parameters/modeset ]]; then
  printf 'NVIDIA DRM modeset: %s\n' "$(cat /sys/module/nvidia_drm/parameters/modeset)"
fi
if command -v nvidia-smi >/dev/null 2>&1; then nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader || true; fi
