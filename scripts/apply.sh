#!/usr/bin/env bash
# Apply MINIMAL GLASS without installing packages or altering GPU/drivers.
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
[[ "$EUID" -ne 0 ]] || { echo "Execute sem sudo."; exit 1; }
for cmd in cp mkdir date python3; do command -v "$cmd" >/dev/null || exit 1; done
# Syntax-check the Lua file without executing Hyprland-specific globals.
# Passing the filename as a Lua script would execute it; loadfile(nil) reads stdin and hangs.
if command -v luac >/dev/null 2>&1; then
  luac -p "$ROOT/dotfiles/hypr/hyprland.lua"
elif command -v lua >/dev/null 2>&1; then
  HYPR_LUA_FILE="$ROOT/dotfiles/hypr/hyprland.lua" lua -e 'assert(loadfile(assert(os.getenv("HYPR_LUA_FILE"))))'
fi
stamp="$(date +%Y%m%d-%H%M%S)"
backup="$HOME/.local/share/minimal-dotfiles/backups/$stamp"
mkdir -p "$backup" "$HOME/.config"
for name in hypr waybar ghostty fuzzel mako; do
  src="$ROOT/dotfiles/$name"
  dst="$HOME/.config/$name"
  [[ -d "$src" ]] || continue
  mkdir -p "$dst"
  for file in "$src"/*; do
    [[ -f "$file" ]] || continue
    base="${file##*/}"
    if [[ -e "$dst/$base" || -L "$dst/$base" ]]; then
      mkdir -p "$backup/$name"
      cp -a -- "$dst/$base" "$backup/$name/$base"
    fi
    cp -a -- "$file" "$dst/$base"
  done
done
if [[ -f "$HOME/.config/hypr/minimal-glass.png" ]]; then
  echo "Wallpaper já existe; preservando."
else
  python3 "$ROOT/scripts/generate-wallpaper.py" "$HOME/.config/hypr/minimal-glass.png"
fi
printf '%s\n' "$backup" > "$HOME/.local/share/minimal-dotfiles/last-glass-backup"
if [[ "${1:-}" == "--nvim" ]]; then
  nvim_dest="$HOME/.config/nvim/lua/plugins/minimal-glass.lua"
  mkdir -p "$(dirname "$nvim_dest")"
  if [[ -e "$nvim_dest" ]]; then
    mkdir -p "$backup/nvim"
    cp -a "$nvim_dest" "$backup/nvim/minimal-glass.lua"
  fi
  cp -a "$ROOT/extras/nvim/lua/plugins/minimal-glass.lua" "$nvim_dest"
fi
echo "Aplicado. Backup: $backup"
echo "Para rollback: bash scripts/rollback-glass.sh"
echo "Reinicie a sessão Hyprland para carregar hyprpaper e todos os efeitos."
