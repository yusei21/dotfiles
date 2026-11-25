#!/usr/bin/env bash
set -euo pipefail
backup=${1:?Usage: bash uninstall.sh BACKUP_DIRECTORY}
[[ -f "$backup/config-installed" && -f "$backup/bin-installed" ]] || exit 2
saved=$(mktemp -d "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/removed-XXXXXX")
for kind in config bin; do
  case "$kind" in config) target="$HOME/.config";; bin) target="$HOME/.local/bin";; esac
  mkdir -p "$saved/$kind" "$target"
  while IFS= read -r name; do
    [[ "$name" =~ ^[a-zA-Z0-9_.-]+$ && "$name" != . && "$name" != .. ]] || exit 2
    if [[ -e "$target/$name" || -L "$target/$name" ]]; then mv -- "$target/$name" "$saved/$kind/$name"; fi
    if [[ -e "$backup/$kind/$name" || -L "$backup/$kind/$name" ]]; then cp -a -- "$backup/$kind/$name" "$target/$name"; fi
  done < "$backup/$kind-installed"
done
printf 'Removed configurations saved at %s\n' "$saved"
