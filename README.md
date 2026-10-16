# MINIMAL / CachyOS · Hyprland · NVIDIA

Dotfiles criados do zero: desktop preto/cinza, sem blur ou animações.

**Stack:** Hyprland, Ghostty, Fish, Starship, Neovim, Brave Origin, LibreWolf, Fuzzel, Waybar, Mako, Yazi, Zellij, Docker, DBeaver, Ollama, Claude Code, Codex e OpenCode.

## Instalação depois de formatar

1. Instale CachyOS com driver NVIDIA apropriado e confirme `nvidia-smi`.
2. `sudo pacman -Syu --needed git`
3. `git clone https://github.com/yusei21/dotfiles.git && cd dotfiles`
4. Revise `scripts/install.sh` e execute `bash scripts/install.sh`
5. `bash scripts/doctor.sh` e reinicie na sessão Hyprland.

### Teclado, Hz e workspaces

- Teclado **US International**: `kb_layout = us`, `kb_variant = intl`.
- Monitores `monitor = , highrr, auto, 1`: escolhe a maior frequência anunciada para cada monitor **mesmo que isso diminua a resolução**. Para fixar Hz na resolução nativa, envie `hyprctl monitors all` depois de iniciar sessão; configure um modo exato por monitor, por exemplo `1920x1080@144` somente se estiver em `availableModes`.
- Workspaces dinâmicos sem regra `workspace = ... monitor:...`; use Super+1–9. Podem migrar de tela com o trabalho.

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

### Ferramentas de IA opcionais

- LazyVim: https://www.lazyvim.org/installation
- Claude Code: https://code.claude.com/docs/en/setup
- Codex: https://developers.openai.com/codex/cli/
- OpenCode: https://opencode.ai/docs/
- Docker: depois de revisar permissões, `sudo systemctl enable --now docker`.
- Ollama: `sudo systemctl enable --now ollama` apenas se desejar serviço permanente.

**Rollback:** `bash scripts/rollback.sh` restaura arquivos guardados, não desinstala pacotes. Nenhum script foi testado no hardware específico. Não armazene chaves nem tokens neste repositório.
