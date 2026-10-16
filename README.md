# MINIMAL / CachyOS · Hyprland · NVIDIA

Dotfiles criados do zero: desktop preto/cinza, sem blur ou animações. **Hyprland 0.55+ usa `dotfiles/hypr/hyprland.lua`**, sem configuração legado em hyprlang.

**Stack:** Hyprland, Ghostty, Fish, Starship, Neovim, Brave Origin, LibreWolf, Fuzzel, Waybar, Mako, Yazi, Zellij, Docker, DBeaver, Ollama, Claude Code, Codex e OpenCode.

## Instalação depois de formatar

1. Instale CachyOS com driver NVIDIA apropriado e confirme `nvidia-smi`.
2. `sudo pacman -Syu --needed git`
3. `git clone https://github.com/yusei21/dotfiles.git && cd dotfiles`
4. Revise `scripts/install.sh` e execute `bash scripts/install.sh`
5. `bash scripts/doctor.sh` e reinicie na sessão Hyprland.

### Teclado, Hz e workspaces

- Teclado **US International** configurado por Lua com `kb_layout = "us"` e `kb_variant = "intl"`.
- Monitores fixados com modos confirmados: **LG UltraGear HDMI-A-1** em `1920x1080@119.98` na posição `0x0`, e **AOC 25G3ZM DP-3** em `1920x1080@239.96` na posição `1920x0`, ambos com escala `1`. LG à esquerda, AOC à direita. Se conectores mudarem após formatar, rode `hyprctl monitors all` e ajuste os nomes; há fallback automático para outras saídas.
- Workspaces dinâmicos sem associação fixa a monitor; use Super+1–9. Podem migrar de tela com o trabalho.

### Atalhos

| Atalho | Ação |
| --- | --- |
| Super+T | Ghostty |
| Super+Q | Fechar janela |
| Super+W | Brave Origin |
| Super+Shift+W | LibreWolf |
| Super+F | Tela cheia |
| Super+Shift+S | Screenshot temporária da região para clipboard |
| Super+setas | Foco da janela |
| Super+Shift+setas | Mover janela |
| Super+1–9 | Workspaces dinâmicos |
| Super+Shift+1–9 | Mover janela para workspace |
| Super+D | Fuzzel |
| Super+E | Yazi (gerenciador de arquivos no terminal) |
| Super+Ctrl+L | Bloquear |

### Seleção e cópia no Ghostty

- **Ctrl+Shift+A** seleciona e copia o texto disponível no terminal automaticamente (ações encadeadas, exige Ghostty 1.3+). **Ctrl+Shift+C** copia uma seleção manual. O histórico além do limite de scrollback não pode ser recuperado dessa forma.
- Para copiar um arquivo inteiro, use `wl-copy < arquivo.conf`. Em Neovim, `ggVG\"+y` copia o buffer com clipboard integrado disponível.
- **Lua é para o Hyprland 0.55+ e Neovim**. Ghostty, Fish, Waybar e outros aplicativos continuam usando seus próprios formatos.

### Ferramentas de IA opcionais

- LazyVim: https://www.lazyvim.org/installation
- Claude Code: https://code.claude.com/docs/en/setup
- Codex: https://developers.openai.com/codex/cli/
- OpenCode: https://opencode.ai/docs/
- Docker: depois de revisar permissões, `sudo systemctl enable --now docker`.
- Ollama: `sudo systemctl enable --now ollama` apenas se desejar serviço permanente.

**Rollback:** `bash scripts/rollback.sh` restaura arquivos guardados, não desinstala pacotes. Nenhum script foi testado no hardware específico. Não armazene chaves nem tokens neste repositório.
