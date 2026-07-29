#!/usr/bin/env bash
set -euo pipefail

# Instala apenas a camada visual do HyDE, preservando as configuracoes
# existentes do Hyprland (monitores, atalhos, input e workspaces).

HYDE_REPO="https://github.com/HyDE-Project/HyDE.git"
TMP_DIR="$(mktemp -d)"
BACKUP_DIR="$HOME/.local/state/visual-hyde-backup/$(date +%Y%m%d-%H%M%S)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$BACKUP_DIR"

backup_path() {
  local path="$1"
  if [[ -e "$path" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "${path#$HOME/}")"
    cp -a "$path" "$BACKUP_DIR/${path#$HOME/}"
  fi
}

for path in \
  "$HOME/.config/rofi" \
  "$HOME/.config/hyde" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash"; do
  backup_path "$path"
done

sudo pacman -S --needed --noconfirm \
  git rsync rofi-wayland swww jq imagemagick \
  kitty dolphin qt6ct kvantum breeze breeze-icons \
  ttf-cascadia-code-nerd

git clone --depth 1 "$HYDE_REPO" "$TMP_DIR/HyDE"

copy_if_present() {
  local source="$1"
  local destination="$2"
  if [[ -e "$source" ]]; then
    mkdir -p "$destination"
    rsync -a "$source"/ "$destination"/
  fi
}

copy_if_present "$TMP_DIR/HyDE/Configs/.config/rofi" "$HOME/.config/rofi"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/hyde" "$HOME/.config/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/hyde" "$HOME/.local/share/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/wallbash" "$HOME/.local/share/wallbash"

# Nao copia Configs/.config/hypr: isso preserva monitores, atalhos,
# input, workspaces e demais preferencias pessoais.

# Desativa hibernacao no sistema. Suspensao normal continua disponivel.
sudo systemctl mask \
  hibernate.target \
  hybrid-sleep.target \
  suspend-then-hibernate.target

# Remove o servidor de notificacoes da sessao atual, caso esteja ativo.
pkill swaync 2>/dev/null || true

printf '\nCamada visual instalada. Backup salvo em:\n%s\n' "$BACKUP_DIR"
printf 'Reinicie a sessao do Hyprland para carregar todos os componentes.\n'
