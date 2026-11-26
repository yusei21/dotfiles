#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
[[ $EUID != 0 ]] || { echo "Run as a normal user"; exit 1; }
[[ "${XDG_CONFIG_HOME:-$HOME/.config}" == "$HOME/.config" ]] || { echo "Nonstandard XDG_CONFIG_HOME is not yet supported"; exit 1; }
dry=false; gaming=true
for arg in "$@"; do case "$arg" in --dry-run) dry=true;; --skip-gaming) gaming=false;; *) exit 2;; esac; done
lists=(packages/core.txt packages/development.txt packages/applications.txt)
if $gaming; then lists+=(packages/gaming.txt); fi
mapfile -t packages < <(grep -hvE '^[[:space:]]*(#|$)' "${lists[@]}" | sort -u)
if $dry; then printf '%s\n' "${packages[@]}"; exit 0; fi
sudo pacman -Syu --needed "${packages[@]}"
cfg="$HOME/.config"
backup="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backup-$(date +%Y%m%d-%H%M%S)-$$"
mkdir -p "$cfg" "$backup/config" "$backup/bin" "$HOME/.local/bin"
printf 'Backup: %s\n' "$backup"
for source in config/*; do
    name=${source##*/}
    if [[ -e "$cfg/$name" || -L "$cfg/$name" ]]; then mv -- "$cfg/$name" "$backup/config/$name"; fi
    cp -a -- "$source" "$cfg/$name"
    printf '%s\n' "$name" >> "$backup/config-installed"
done
for source in scripts/dot-*; do
    name=${source##*/}
    if [[ -e "$HOME/.local/bin/$name" || -L "$HOME/.local/bin/$name" ]]; then mv -- "$HOME/.local/bin/$name" "$backup/bin/$name"; fi
    install -m 755 "$source" "$HOME/.local/bin/$name"
    printf '%s\n' "$name" >> "$backup/bin-installed"
done
sed -i "s|^color_scheme_path=.*|color_scheme_path=$cfg/qt6ct/colors/monochrome.conf|" "$cfg/qt6ct/qt6ct.conf"
mkdir -p "$HOME/Pictures/Wallpapers/"{horizontal,vertical}
git lfs install --skip-repo
printf 'Finished. Review packages/optional.txt. Use chsh -s /usr/bin/fish for TTY startup.\n'
