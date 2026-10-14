# MINIMAL / CachyOS · Hyprland · NVIDIA

Dotfiles **novos do zero** para CachyOS, Wayland e NVIDIA. Desktop preto/cinza, sem blur, animações ou componentes dispensáveis.

**Stack:** Hyprland, Ghostty, Fish, Starship, Neovim (LazyVim opcional), Firefox, Fuzzel, Waybar, Mako, Yazi, Zellij, Docker, DBeaver, Ollama, Claude Code, Codex, OpenCode.

## Instalar após formatar

1. Instale CachyOS com driver NVIDIA adequado à sua GPU. Confirme `nvidia-smi` antes de tentar iniciar o Hyprland.
2. Instale Git: `sudo pacman -Syu --needed git`.
3. `git clone https://github.com/yusei21/dotfiles.git && cd dotfiles`.
4. **Leia** `scripts/install.sh` e rode `bash scripts/install.sh`. Ele pede confirmação, instala somente pacotes disponíveis, cria backups, e **não** altera drivers, shell padrão ou habilita serviços.
5. Rode `bash scripts/doctor.sh`; reinicie e selecione Hyprland no gerenciador de login.

O teclado inicia em **ABNT2** (edite `dotfiles/hypr/hyprland.conf` se necessário). Monitor automático. Super+Enter terminal, Super+D aplicativos, Super+B navegador, Super+E arquivos, Super+H/J/K/L foco, Super+Shift+Q fechar, Super+Ctrl+L bloquear, Super+1..5 workspaces.

### Instalações opcionais, deliberadamente manuais

- LazyVim: https://www.lazyvim.org/installation (exige conferir dependências e fazer backup do seu Neovim antes)
- Claude Code: https://code.claude.com/docs/en/setup
- Codex: https://developers.openai.com/codex/cli/
- OpenCode: https://opencode.ai/docs/
- Docker: após conferir os riscos do grupo docker, `sudo systemctl enable --now docker`; considere rootless Docker.
- Ollama: `sudo systemctl enable --now ollama` apenas quando desejar serviço permanente; consulte https://docs.ollama.com/linux e valide suporte GPU.
- Não coloque chaves/tokens nem arquivos `.env` no Git.

**Rollback local:** `bash scripts/rollback.sh`. Restaura arquivos de configuração salvos, sem remover pacotes. Este setup é um ponto de partida, não foi testado no seu hardware específico. O histórico Git anterior continua recuperável após substituição.
