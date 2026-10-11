#!/usr/bin/env bash
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -f "$root/HyDE/Scripts/install.sh" ]]; then
  git -C "$root" submodule update --init --recursive
fi
if [[ ! -f "$root/HyDE/Scripts/install.sh" ]]; then
  echo "HyDE nao encontrado. Execute: git submodule update --init --recursive" >&2
  exit 1
fi
# Copia de seguranca da configuracao existente, sem alterar o sistema antes da instalacao.
user_cfg="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.lua"
mkdir -p "$(dirname "$user_cfg")"
if [[ -f "$user_cfg" ]]; then
  cp -a -- "$user_cfg" "$user_cfg.backup.$(date +%Y%m%d-%H%M%S)"
fi
# A instalacao do HyDE e feita pelo instalador oficial, com seus argumentos.
bash "$root/HyDE/Scripts/install.sh" "$@"
# Aplicar sobre a configuracao oficial, sem editar os arquivos internos do HyDE.
install -m 644 "$root/overrides/hyprland.lua" "$user_cfg"
echo "Personalizacoes aplicadas em $user_cfg"
echo "Reinicie a sessao Hyprland para carregar as alteracoes."
