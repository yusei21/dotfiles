#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
[[ $EUID != 0 ]] || { echo "Run as a normal user"; exit 1; }
mapfile -t packages < packages/core.txt
if [[ ${1:-} == --dry-run ]]; then printf '%s\n' "${packages[@]}"; exit 0; fi
[[ ${1:-} == "" ]] || exit 2
sudo pacman -Syu --needed "${packages[@]}"
cfg="${XDG_CONFIG_HOME:-$HOME/.config}"
backup="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backup-$(date +%Y%m%d-%H%M%S)-$$"
mkdir -p "$cfg" "$backup" "$HOME/.local/bin"
for source in config/*; do
    name=${source##*/}
    if [[ -e "$cfg/$name" || -L "$cfg/$name" ]]; then mv -- "$cfg/$name" "$backup/$name"; fi
    cp -a -- "$source" "$cfg/$name"
done
if [[ -e "$HOME/.local/bin/dot-wall" || -L "$HOME/.local/bin/dot-wall" ]]; then mv "$HOME/.local/bin/dot-wall" "$backup/dot-wall"; fi
install -m 755 scripts/dot-wall "$HOME/.local/bin/dot-wall"
mkdir -p "$HOME/Pictures/Wallpapers/"{horizontal,vertical}
printf 'Backup: %s\n' "$backup"
