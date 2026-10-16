#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
[[ $EUID -ne 0 ]] || { echo "Execute sem sudo (o script pedirá sudo somente para pacman)."; exit 1; }
command -v pacman >/dev/null || { echo "Requer CachyOS/Arch com pacman."; exit 1; }
source /etc/os-release
[[ "${ID:-}" == cachyos || "${ID:-}" == arch || " ${ID_LIKE:-} " == *" arch "* ]] || { echo "Distribuição não identificada como Arch/CachyOS."; exit 1; }
echo "Instala pacotes e substitui configs selecionadas em ~/.config (com backup)."
echo "Não modifica drivers, shell padrão, bootloader nem serviços."
read -rp "Continuar? [s/N] " answer
[[ "$answer" == [sS] ]] || exit 0
packages=(hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xorg-xwayland ghostty fish starship neovim git curl fzf ripgrep fd jq brave-origin-bin librewolf dolphin cliphist fuzzel waybar mako hyprlock hypridle grim slurp wl-clipboard pipewire wireplumber pipewire-pulse networkmanager polkit-kde-agent yazi lazygit lazydocker btop zellij docker docker-compose ollama dbeaver ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji)
available=()
for p in "${packages[@]}"; do
  if pacman -Si "$p" >/dev/null 2>&1; then available+=("$p"); else echo "Não encontrado no repositório: $p"; fi
done
(("${#available[@]}" > 0)) && sudo pacman -S --needed "${available[@]}"
stamp="$(date +%Y%m%d-%H%M%S)"
backup="$HOME/.local/share/minimal-dotfiles/backups/$stamp"
mkdir -p "$backup" "$HOME/.config"
for name in hypr waybar ghostty fish fuzzel mako zellij; do
  source_dir="$ROOT/dotfiles/$name"
  dest="$HOME/.config/$name"
  [[ -d "$source_dir" ]] || continue
  [[ ! -e "$dest" && ! -L "$dest" ]] || mv -- "$dest" "$backup/$name"
  cp -a -- "$source_dir" "$dest"
done
if [[ -f "$ROOT/dotfiles/starship.toml" ]]; then
  dest="$HOME/.config/starship.toml"
  [[ ! -e "$dest" && ! -L "$dest" ]] || mv -- "$dest" "$backup/starship.toml"
  cp -- "$ROOT/dotfiles/starship.toml" "$dest"
fi
printf '%s\n' "$backup" > "$HOME/.local/share/minimal-dotfiles/last-backup"
echo "Concluído. Backup: $backup"
echo "Verifique com: bash scripts/doctor.sh"
