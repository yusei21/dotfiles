# MINIMAL GLASS / CachyOS · Hyprland · NVIDIA

Dotfiles criados do zero: desktop preto/cinza com vidro fosco, blur seletivo e animações desativadas. **Hyprland 0.55+ usa `dotfiles/hypr/hyprland.lua`**, sem configuração legado em hyprlang.

**Stack:** Hyprland, Ghostty, Fish, Starship, Neovim, Brave Origin, LibreWolf, Fuzzel, Waybar, Mako, Yazi, Zellij, Docker, DBeaver, Ollama, Claude Code, Codex e OpenCode.

## Instalação depois de formatar

1. Instale CachyOS com driver NVIDIA apropriado e confirme `nvidia-smi`.
2. `sudo pacman -Syu --needed git`
3. `git clone https://github.com/yusei21/dotfiles.git && cd dotfiles`
4. Revise `scripts/install.sh` e execute `bash scripts/install.sh`
5. `bash scripts/doctor.sh` e reinicie na sessão Hyprland.

### Teclado, Hz e workspaces

- Teclado **US International** configurado por Lua com `kb_layout = "us"` e `kb_variant = "intl"`.
- **Shift+Esc** insere `~` diretamente no terminal e em outros aplicativos via `wtype` (sem precisar de espaço). Instale com `sudo pacman -S --needed wtype` e reinicie/recarregue o Hyprland após aplicar a configuração.
- Monitores: **Dell AW2525HM DP-3** à esquerda em `1920x1080@319.98` (posição `0x420`, horizontal e centralizado verticalmente em relação ao LG) e **LG UltraGear HDMI-A-1** à direita em `1920x1080@119.98` (posição `1920x0`, `transform = 3` para rotação de 270°). Ambos com escala `1`. As frequências foram confirmadas por `hyprctl monitors all`; o Dell apresentou 319,98 Hz como modo máximo disponível nessa conexão. Se os conectores mudarem, rode `hyprctl monitors all` e ajuste os nomes; há fallback automático para outras saídas.
- Workspaces dinâmicos sem associação fixa a monitor; use Super+1–9. Podem migrar de tela com o trabalho.

### Atalhos

| Atalho | Ação |
| --- | --- |
| Super+T | Ghostty |
| Super+Q | Fechar janela |
| Super+W | Brave Origin |
| Super+Shift+W | LibreWolf |
| Super+F | Tela cheia |
| Super+Shift+S | Selecionar região, editar com Satty e escolher copiar ou salvar |
| Super+setas | Foco da janela |
| Super+Shift+setas | Mover janela |
| Super+1–9 | Workspaces dinâmicos |
| Super+Shift+1–9 | Mover janela para workspace |
| Super+D | Fuzzel |
| Super+E | Yazi (gerenciador de arquivos no terminal) |
| Super+Ctrl+L | Bloquear |

### Capturas de tela

- **Super+Shift+S** permite selecionar a região com `slurp` e editar com `satty` (desenhar, destacar, setas e texto).
- No Satty, **Ctrl+C** copia sem salvar; **Ctrl+S** salva em `~/Pictures/Screenshots/` sem copiar; **Ctrl+Shift+S** abre o diálogo Salvar como. O diretório é criado ao acionar o atalho.
- Instale as dependências após atualizar os dotfiles: `sudo pacman -Syu --needed satty grim slurp wl-clipboard`. O `git pull` sozinho não instala pacotes nem copia a configuração para `~/.config`.

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


## MINIMAL GLASS (tema padrão)

Tema grafite com transparência em Ghostty, Fuzzel, Mako e Waybar; blur seletivo
no Hyprland 0.55+ Lua, sem mudar driver NVIDIA nem a configuração dos dois monitores.
O wallpaper é gerado localmente por `scripts/generate-wallpaper.py` (Python stdlib).
**Hyprpaper 0.8+ é necessário** para o formato atual de `hyprpaper.conf`.

### Aplicar a um desktop existente

```bash
git fetch origin
git switch feat/minimal-glass
bash scripts/apply.sh --nvim
bash scripts/doctor.sh
```

O `--nvim` é opcional: se usar LazyVim, instala a configuração visual opcional em
`~/.config/nvim/lua/plugins/minimal-glass.lua`. Ela usa Tokyo Night e fundo transparente
para permitir que a transparência do Ghostty apareça por trás. Outros arquivos do
Neovim são preservados. Sem LazyVim, não use a opção `--nvim`.

O `apply.sh` não instala pacotes nem modifica driver, serviços ou arquivos de perfil do Brave.
Se faltar o Hyprpaper: `sudo pacman -S --needed hyprpaper`.
Depois de aplicar, encerre e inicie novamente a sessão Hyprland para carregar o wallpaper.
Para conferir a configuração use `hyprctl configerrors`, `hyprctl layers`,
`hyprctl monitors all` e `nvidia-smi`.

### Brave Origin

No Brave, abra `brave://settings/appearance` e escolha o tema escuro. A interface
nativa de abas, barra de endereços e páginas internas do Chromium não oferece
transparência de vidro fosco universal confiável. O arquivo opcional
`extras/brave/minimal-glass.user.css` pode ser usado no Stylus **por site**,
sem modificar o perfil, desativar segurança, forçar flags experimentais ou injetar
CSS em páginas sensíveis. Esse arquivo afeta apenas conteúdo web, não a toolbar.

### Reverter alterações visuais

```bash
bash scripts/rollback-glass.sh
```

O script restaura os arquivos anteriores **que foram salvos** antes do apply.
Arquivos criados pela primeira vez (como hyprpaper.conf e o tema opcional do
Neovim) precisam de remoção manual se você quiser voltar ao estado exato anterior.
O backup de instalação em `last-backup` é independente do backup visual em
`last-glass-backup`. Não rode o `rollback.sh` antigo para reverter apenas o tema.

### Observações de compatibilidade

- Gaps, monitor DP-3 a 319,98 Hz e HDMI-A-1 a 119,98 Hz vertical, teclado US intl e atalhos preservados.
- Opacidade de janelas do compositor em 100%; transparência é configurada por aplicativo.
- Sem animações extras para priorizar legibilidade e fluidez na NVIDIA.
- Se houver problemas com blur, reduza `passes` para 1 ou desabilite `decoration.blur.enabled` em `hyprland.lua`.
- Os namespaces de layer-shell devem ser conferidos com `hyprctl layers` na máquina real.
- Configurações não foram validadas no hardware real. Faça login novamente somente depois de revisar as diferenças.
