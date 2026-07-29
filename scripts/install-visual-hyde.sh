#!/usr/bin/env bash
set -euo pipefail

# Instala somente a camada visual do HyDE. A configuracao existente do
# Hyprland nao e substituida: monitores, atalhos, input e workspaces ficam intactos.

HYDE_REPO="https://github.com/HyDE-Project/HyDE.git"
HYDE_REF="fd70502f95142c242d0ce2d2e569f6fd1d7dd626"
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
  "$HOME/.config/kitty" \
  "$HOME/.config/qt6ct" \
  "$HOME/.config/Kvantum" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash"; do
  backup_path "$path"
done

sudo pacman -S --needed --noconfirm \
  git rsync rofi swww jq imagemagick \
  kitty dolphin qt6ct kvantum breeze breeze-icons \
  ttf-cascadia-code-nerd

git clone --filter=blob:none --no-checkout "$HYDE_REPO" "$TMP_DIR/HyDE"
git -C "$TMP_DIR/HyDE" checkout "$HYDE_REF"

copy_if_present() {
  local source="$1"
  local destination="$2"
  if [[ -e "$source" ]]; then
    mkdir -p "$destination"
    rsync -a "$source"/ "$destination"/
  fi
}

# Componentes solicitados: Rofi, seletores de tema/wallpaper/launcher e Wallbash.
copy_if_present "$TMP_DIR/HyDE/Configs/.config/rofi" "$HOME/.config/rofi"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/hyde" "$HOME/.config/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/hyde" "$HOME/.local/share/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/wallbash" "$HOME/.local/share/wallbash"

# Aparencia do terminal e dos aplicativos Qt/Dolphin, sem trocar o Dolphin.
copy_if_present "$TMP_DIR/HyDE/Configs/.config/kitty" "$HOME/.config/kitty"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/qt6ct" "$HOME/.config/qt6ct"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/Kvantum" "$HOME/.config/Kvantum"

# Nao copia Configs/.config/hypr. Assim, monitores, atalhos, input,
# workspaces e demais preferencias do Hyprland permanecem inalterados.

# Hibernacao desativada; a suspensao normal continua disponivel.
sudo systemctl mask \
  hibernate.target \
  hybrid-sleep.target \
  suspend-then-hibernate.target

# Notificacoes excluidas da integracao.
pkill swaync 2>/dev/null || true

printf '\nCamada visual instalada. Backup salvo em:\n%s\n' "$BACKUP_DIR"
printf 'Reinicie a sessao do Hyprland. Os seletores podem exigir atalhos manuais,\n'
printf 'pois este instalador nao substitui o seu arquivo de binds.\n'
