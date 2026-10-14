#!/usr/bin/env bash
set -Eeuo pipefail
pointer="$HOME/.local/share/minimal-dotfiles/last-backup"
[[ -f "$pointer" ]] || { echo "Sem backup registrado."; exit 1; }
backup="$(cat "$pointer")"
[[ -d "$backup" && "$backup" == "$HOME/.local/share/minimal-dotfiles/backups/"* ]] || { echo "Backup inválido."; exit 1; }
read -rp "Restaurar dotfiles de $backup? [s/N] " answer
[[ "$answer" == [sS] ]] || exit 0
current="$HOME/.local/share/minimal-dotfiles/pre-rollback-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$current"
for name in hypr waybar ghostty fish fuzzel mako zellij starship.toml; do
  dest="$HOME/.config/$name"
  [[ ! -e "$dest" && ! -L "$dest" ]] || mv -- "$dest" "$current/$name"
  [[ ! -e "$backup/$name" && ! -L "$backup/$name" ]] || mv -- "$backup/$name" "$dest"
done
echo "Restaurado. Configuração substituída guardada em $current"
