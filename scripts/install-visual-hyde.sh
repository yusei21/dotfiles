#!/usr/bin/env bash
set -euo pipefail

# Instala somente a camada visual do HyDE. A configuracao existente do
# Hyprland nao e substituida: monitores, input e workspaces ficam intactos.

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
  "$HOME/.config/lf" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash" \
  "$HOME/.config/hypr/configs/autostart.conf" \
  "$HOME/.config/hypr/configs/binds.conf"; do
  backup_path "$path"
done

sudo pacman -S --needed --noconfirm \
  git rsync rofi swww jq imagemagick \
  kitty dolphin dolphin-plugins ffmpegthumbs kdegraphics-thumbnailers \
  qt6ct kvantum breeze breeze-icons ttf-cascadia-code-nerd

# Remove o gerenciador antigo (lf), se estiver instalado.
if pacman -Qq lf >/dev/null 2>&1; then
  sudo pacman -Rns --noconfirm lf
fi
rm -rf "$HOME/.config/lf"

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

# Componentes solicitados: Rofi, tema, wallpaper, launcher e Wallbash.
copy_if_present "$TMP_DIR/HyDE/Configs/.config/rofi" "$HOME/.config/rofi"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/hyde" "$HOME/.config/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/hyde" "$HOME/.local/share/hyde"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/share/wallbash" "$HOME/.local/share/wallbash"
copy_if_present "$TMP_DIR/HyDE/Configs/.local/lib/hyde" "$HOME/.local/lib/hyde"

# Aparencia do terminal e dos aplicativos Qt/Dolphin.
copy_if_present "$TMP_DIR/HyDE/Configs/.config/kitty" "$HOME/.config/kitty"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/qt6ct" "$HOME/.config/qt6ct"
copy_if_present "$TMP_DIR/HyDE/Configs/.config/Kvantum" "$HOME/.config/Kvantum"

# Remove da copia do HyDE tudo relacionado a notificacoes, central de
# notificacoes, tela de energia/logout e hibernacao.
for root in \
  "$HOME/.config/rofi" \
  "$HOME/.config/hyde" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash" \
  "$HOME/.local/lib/hyde"; do
  [[ -d "$root" ]] || continue
  find "$root" -depth \
    \( -iname '*notification*' -o -iname '*swaync*' -o \
       -iname '*powermenu*' -o -iname '*power-menu*' -o \
       -iname '*logout*' -o -iname '*wlogout*' -o \
       -iname '*hibernate*' \) \
    -exec rm -rf -- {} + 2>/dev/null || true
done

# Remove apenas entradas associadas aos recursos excluidos e troca o atalho
# SUPER+E do antigo "kitty -e lf" para o Dolphin.
AUTOSTART="$HOME/.config/hypr/configs/autostart.conf"
BINDS="$HOME/.config/hypr/configs/binds.conf"

if [[ -f "$AUTOSTART" ]]; then
  sed -i -E '/swaync|swaync-client|wlogout|powermenu|power-menu|systemctl[[:space:]]+hibernate|suspend-then-hibernate/d' "$AUTOSTART"
fi

if [[ -f "$BINDS" ]]; then
  sed -i -E '/swaync|swaync-client|wlogout|powermenu|power-menu|systemctl[[:space:]]+hibernate|suspend-then-hibernate/d' "$BINDS"
  sed -i -E 's|^bind[[:space:]]*=[[:space:]]*\$mainMod,[[:space:]]*E,[[:space:]]*exec,.*$|bind = $mainMod, E, exec, dolphin|' "$BINDS"
fi

# Define o Dolphin como gerenciador de arquivos padrao.
xdg-mime default org.kde.dolphin.desktop inode/directory || true
xdg-mime default org.kde.dolphin.desktop application/x-gnome-saved-search || true

# Encerra os processos removidos na sessao atual.
pkill swaync 2>/dev/null || true
pkill wlogout 2>/dev/null || true
pkill -x lf 2>/dev/null || true

# Hibernacao desativada permanentemente ate ser desmascarada manualmente.
# A suspensao normal continua disponivel.
sudo systemctl mask \
  hibernate.target \
  hybrid-sleep.target \
  suspend-then-hibernate.target

printf '\nCamada visual instalada. Backup salvo em:\n%s\n' "$BACKUP_DIR"
printf 'Dolphin definido no SUPER+E e como gerenciador de arquivos padrao.\n'
printf 'O lf, notificacoes, menu de energia/logout e hibernacao foram removidos.\n'
printf 'Reinicie a sessao do Hyprland para concluir.\n'
