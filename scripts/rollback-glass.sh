#!/usr/bin/env bash
set -Eeuo pipefail
pointer="$HOME/.local/share/minimal-dotfiles/last-backup"
[[ -f "$pointer" ]] || { echo "Nenhum backup de aplicação encontrado."; exit 1; }
backup="$(cat "$pointer")"
[[ "$backup" == "$HOME/.local/share/minimal-dotfiles/backups/"* && -d "$backup" ]] || exit 1
read -rp "Restaurar arquivos do último apply? [s/N] " answer
[[ "$answer" == [sS] ]] || exit 0
snapshot="$HOME/.local/share/minimal-dotfiles/pre-rollback-glass-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$snapshot"
for name in hypr waybar ghostty fuzzel mako; do
  [[ -d "$backup/$name" ]] || continue
  mkdir -p "$snapshot/$name" "$HOME/.config/$name"
  for file in "$backup/$name"/*; do
    [[ -f "$file" ]] || continue
    base="${file##*/}"
    [[ ! -e "$HOME/.config/$name/$base" ]] || cp -a "$HOME/.config/$name/$base" "$snapshot/$name/$base"
    cp -a -- "$file" "$HOME/.config/$name/$base"
  done
done
echo "Restaurados arquivos com backup. Arquivos novos precisam de revisão manual."
echo "Estado substituído guardado em: $snapshot"
