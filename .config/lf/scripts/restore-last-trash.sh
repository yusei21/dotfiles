#!/usr/bin/env bash
set -euo pipefail
trash_base="${XDG_DATA_HOME:-$HOME/.local/share}/Trash"
info_dir="$trash_base/info"
files_dir="$trash_base/files"
info="$(ls -t "$info_dir"/*.trashinfo 2>/dev/null | head -n 1 || true)"
if [ -z "$info" ]; then
  if command -v notify-send >/dev/null 2>&1; then notify-send "LF undo" "Lixeira vazia"; fi
  printf "Lixeira vazia\n"
  exit 0
fi
raw_path="$(grep -m1 "^Path=" "$info" | cut -d= -f2-)"
orig="$(python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$raw_path")"
name="$(basename "$info" .trashinfo)"
src="$files_dir/$name"
if [ ! -e "$src" ]; then
  printf "Arquivo da lixeira nao encontrado: %s\n" "$src"
  exit 1
fi
if [ -e "$orig" ]; then
  ts="$(date +%Y%m%d-%H%M%S)"
  orig="${orig}.restored-$ts"
fi
mkdir -p "$(dirname "$orig")"
mv "$src" "$orig"
rm -f "$info"
if command -v notify-send >/dev/null 2>&1; then notify-send "LF undo" "Restaurado: $orig"; fi
printf "Restaurado: %s\n" "$orig"
if [ -n "${id:-}" ] && command -v lf >/dev/null 2>&1; then lf -remote "send $id reload" 2>/dev/null || true; fi
