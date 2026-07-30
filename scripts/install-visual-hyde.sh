#!/usr/bin/env bash
set -Eeuo pipefail

HYDE_REPO="https://github.com/HyDE-Project/HyDE.git"
HYDE_REF="fd70502f95142c242d0ce2d2e569f6fd1d7dd626"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$(mktemp -d)"
BACKUP_DIR="$HOME/.local/state/visual-hyde-backup/$(date +%Y%m%d-%H%M%S)"

readonly HYDE_REPO HYDE_REF SCRIPT_DIR TMP_DIR BACKUP_DIR

log() {
  printf '[visual-hyde] %s\n' "$*"
}

cleanup() {
  rm -rf -- "$TMP_DIR"
}
trap cleanup EXIT

backup_path() {
  local path="$1"
  local relative

  [[ -e "$path" || -L "$path" ]] || return 0
  relative="${path#$HOME/}"
  mkdir -p "$BACKUP_DIR/$(dirname "$relative")"
  cp -a -- "$path" "$BACKUP_DIR/$relative"
}

copy_tree() {
  local source="$1"
  local destination="$2"

  [[ -e "$source" ]] || return 0
  mkdir -p "$destination"
  rsync -a -- "$source"/ "$destination"/
}

remove_matching_lines() {
  local root="$1"
  local expression="$2"
  local file

  [[ -d "$root" ]] || return 0
  while IFS= read -r -d '' file; do
    sed -i -E "/${expression}/d" "$file"
  done < <(find "$root" -type f -print0 2>/dev/null)
}

mask_user_service() {
  local service="$1"

  systemctl --user disable --now "$service" 2>/dev/null || true
  systemctl --user mask "$service" 2>/dev/null || true
}

install_local_command() {
  local name="$1"
  local source="$SCRIPT_DIR/$name"

  [[ -f "$source" ]] || {
    printf 'Comando empacotado não encontrado: %s\n' "$source" >&2
    return 1
  }
  install -m 0755 "$source" "$HOME/.local/bin/$name"
}

mkdir -p "$BACKUP_DIR"

log "Criando backup em $BACKUP_DIR"
for path in \
  "$HOME/.config/rofi" \
  "$HOME/.config/hyde" \
  "$HOME/.config/kitty" \
  "$HOME/.config/qt6ct" \
  "$HOME/.config/Kvantum" \
  "$HOME/.config/lf" \
  "$HOME/.config/swaync" \
  "$HOME/.config/mako" \
  "$HOME/.local/bin/hyde-shell" \
  "$HOME/.local/bin/sync-wallbash-theme" \
  "$HOME/.local/bin/select-hyde-theme" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash" \
  "$HOME/.config/hypr/conf/autostart.conf" \
  "$HOME/.config/hypr/configs/autostart.conf" \
  "$HOME/.config/hypr/configs/binds.conf" \
  "$HOME/.config/hypr/configs/layer_rules.conf" \
  "$HOME/.config/hypr/hypridle.conf"; do
  backup_path "$path"
done

log "Instalando dependências"
sudo pacman -S --needed --noconfirm \
  git rsync rofi swww jq imagemagick \
  kitty dolphin dolphin-plugins ffmpegthumbs kdegraphics-thumbnailers \
  qt6ct kvantum breeze breeze-icons ttf-cascadia-code-nerd

if pacman -Qq lf >/dev/null 2>&1; then
  sudo pacman -Rns --noconfirm lf
fi
rm -rf -- "$HOME/.config/lf"

log "Baixando HyDE na revisão fixada"
git clone --quiet --filter=blob:none --no-checkout "$HYDE_REPO" "$TMP_DIR/HyDE"
git -C "$TMP_DIR/HyDE" checkout --quiet "$HYDE_REF"

log "Copiando somente os componentes visuais"
copy_tree "$TMP_DIR/HyDE/Configs/.config/rofi" "$HOME/.config/rofi"
copy_tree "$TMP_DIR/HyDE/Configs/.config/hyde" "$HOME/.config/hyde"
copy_tree "$TMP_DIR/HyDE/Configs/.local/share/hyde" "$HOME/.local/share/hyde"
copy_tree "$TMP_DIR/HyDE/Configs/.local/share/wallbash" "$HOME/.local/share/wallbash"
copy_tree "$TMP_DIR/HyDE/Configs/.local/lib/hyde" "$HOME/.local/lib/hyde"
copy_tree "$TMP_DIR/HyDE/Configs/.config/kitty" "$HOME/.config/kitty"
copy_tree "$TMP_DIR/HyDE/Configs/.config/qt6ct" "$HOME/.config/qt6ct"
copy_tree "$TMP_DIR/HyDE/Configs/.config/Kvantum" "$HOME/.config/Kvantum"

mkdir -p "$HOME/.local/bin"
install -m 0755 "$TMP_DIR/HyDE/Configs/.local/bin/hyde-shell" "$HOME/.local/bin/hyde-shell"
install_local_command sync-wallbash-theme
install_local_command select-hyde-theme

log "Removendo notificações, menus de energia e hibernação"
for root in \
  "$HOME/.config/rofi" \
  "$HOME/.config/hyde" \
  "$HOME/.local/share/hyde" \
  "$HOME/.local/share/wallbash" \
  "$HOME/.local/lib/hyde"; do
  [[ -d "$root" ]] || continue
  find "$root" -depth \
    \( -iname '*notification*' -o -iname '*swaync*' -o -iname '*mako*' -o \
       -iname '*powermenu*' -o -iname '*power-menu*' -o \
       -iname '*logout*' -o -iname '*wlogout*' -o \
       -iname '*hibernate*' \) \
    -exec rm -rf -- {} + 2>/dev/null || true
done

rm -rf -- "$HOME/.config/swaync" "$HOME/.config/mako"

remove_matching_lines "$HOME/.config/hypr" \
  'swaync|swaync-client|swaync-notification-window|swaync-control-center|(^|[[:space:]])mako([[:space:]]|$)|wlogout|powermenu|power-menu|systemctl[[:space:]]+(hibernate|poweroff|suspend|suspend-then-hibernate)'
remove_matching_lines "$HOME/.local/share/hyde/migration" \
  'swaync|swaync-client|swaync-notification-window|swaync-control-center|(^|[[:space:]])mako([[:space:]]|$)'

log "Desativando qualquer ação automática por inatividade"
pkill -x hypridle 2>/dev/null || true
mask_user_service hypridle.service
remove_matching_lines "$HOME/.config/hypr" '(^|[[:space:]])hypridle([[:space:]]|$)'

if [[ -f "$HOME/.config/hypr/hypridle.conf" ]]; then
  cat > "$HOME/.config/hypr/hypridle.conf" <<'EOF'
general {
    # Ações automáticas por inatividade foram desativadas.
}
EOF
fi

log "Configurando Dolphin"
BINDS="$HOME/.config/hypr/configs/binds.conf"
if [[ -f "$BINDS" ]]; then
  sed -i -E \
    's|^bind[[:space:]]*=[[:space:]]*\$mainMod,[[:space:]]*E,[[:space:]]*exec,.*$|bind = $mainMod, E, exec, dolphin|' \
    "$BINDS"
fi
xdg-mime default org.kde.dolphin.desktop inode/directory || true
xdg-mime default org.kde.dolphin.desktop application/x-gnome-saved-search || true

log "Preparando Wallbash para o Antigravity IDE"
WALLBASH_CODE="$HOME/.config/hyde/wallbash/scripts/code.sh"
if [[ -f "$WALLBASH_CODE" ]]; then
  sed -i \
    's|-name "Cursor\*"|-name "Cursor*" -o -name "Antigravity IDE*"|' \
    "$WALLBASH_CODE"
  sed -i \
    '/pkg_installed vscodium/a\            pkg_installed antigravity-ide \&\& antigravity-ide --install-extension "${cacheDir}/landing/Code_Wallbash.vsix" --force' \
    "$WALLBASH_CODE"
fi

log "Encerrando e bloqueando servidores de notificação"
for daemon in swaync mako dunst fnott; do
  pkill -x "$daemon" 2>/dev/null || true
  mask_user_service "$daemon.service"
done
pkill -x wlogout 2>/dev/null || true
pkill -x lf 2>/dev/null || true

log "Desativando hibernação"
sudo systemctl mask \
  hibernate.target \
  hybrid-sleep.target \
  suspend-then-hibernate.target

cat <<EOF

Camada visual instalada.
Backup salvo em: $BACKUP_DIR
Dolphin definido no SUPER+E.
hyde-shell, select-hyde-theme e sync-wallbash-theme instalados em ~/.local/bin.
Notificações e ações automáticas por inatividade foram desativadas.
Hibernação e menus de energia/logout foram removidos.
Use select-hyde-theme para sincronizar Kitty, Antigravity IDE e Spotify.
Reinicie a sessão do Hyprland para concluir.
EOF
