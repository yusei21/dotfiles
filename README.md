# Dotfiles Hyprland

Configuração pessoal para CachyOS/Arch com Hyprland, Waybar, Rofi, SwayNC,
Kitty, Neovim, Fastfetch, Fish/Zsh e integração visual com pywal/Wallbash.

## Principais recursos

- Hyprland com atalhos organizados por categoria.
- Waybar compacta com workspaces, relógio, gravação, bateria, Bluetooth e rede.
- Rofi para launcher, clipboard, Wi-Fi e seleção de wallpaper.
- SwayNC estilizado para notificações e central de controle.
- Kitty com tema dinâmico via pywal.
- Scripts para wallpaper, tema, volume, brilho, screenshots, gravação e bateria.
- Instalador opcional para integrar componentes visuais selecionados do HyDE.

## Pré-requisitos

Este setup foi pensado para Arch/CachyOS com sessão Wayland. Antes de instalar,
garanta que os pacotes principais estejam disponíveis:

```bash
sudo pacman -S --needed \
  git rsync hyprland waybar rofi kitty swaync hyprlock hypridle \
  pywal imagemagick jq brightnessctl pamixer playerctl wl-clipboard cliphist \
  hyprshot awww dolphin fastfetch
```

Alguns recursos são opcionais e só funcionam se o pacote correspondente estiver
instalado:

- `bluetooth`/`bluetui` para o módulo de Bluetooth.
- `spotify` e Spicetify para o tema do Spotify.
- `antigravity-ide` para o atalho e integração visual do IDE.
- Nerd Fonts usadas nos temas, especialmente `DepartureMono Nerd Font`.

## Instalação rápida

Clone o repositório:

```bash
git clone https://github.com/yusei21/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Crie um backup das configurações atuais:

```bash
mkdir -p ~/.local/state/dotfiles-backup
cp -a ~/.config ~/.zshrc ~/.local/state/dotfiles-backup/ 2>/dev/null || true
```

Copie as configurações:

```bash
rsync -av --exclude='.git' .config/ ~/.config/
cp -f .zshrc ~/.zshrc
```

Crie a pasta de wallpapers e defina um wallpaper inicial:

```bash
mkdir -p ~/wallpaper
cp /caminho/para/seu/wallpaper.png ~/wallpaper/wallpaper.png
```

Recarregue o Hyprland ou reinicie a sessão:

```bash
hyprctl reload
```

## Instalação da camada visual HyDE

O repositório inclui um instalador opcional para importar somente partes visuais
do HyDE, sem substituir a base pessoal do Hyprland.

Leia o script antes de executar:

```bash
sed -n '1,260p' scripts/install-visual-hyde.sh
```

Execute:

```bash
chmod +x scripts/install-visual-hyde.sh
./scripts/install-visual-hyde.sh
```

O instalador cria backups em:

```text
~/.local/state/visual-hyde-backup/
```

Depois da instalação, use:

```bash
select-hyde-theme
sync-wallbash-theme
```

## Atalhos úteis

| Atalho | Ação |
| --- | --- |
| `SUPER + Space` | Abrir Rofi |
| `SUPER + Return` | Abrir Kitty |
| `SUPER + Shift + Return` | Abrir Kitty flutuante |
| `SUPER + E` | Abrir Dolphin |
| `SUPER + W` | Abrir navegador |
| `SUPER + A` | Selecionar wallpaper |
| `SUPER + B` | Trocar para wallpaper aleatório |
| `SUPER + R` | Iniciar/parar gravação |
| `SUPER + L` | Bloquear sessão |
| `SUPER + Shift + R` | Recarregar Hyprland |
| `SUPER + Shift + O` | Reiniciar Waybar |
| `SUPER + Shift + V` | Abrir gerenciador de clipboard |
| `Print` | Screenshot do monitor para clipboard |
| `Ctrl + Print` | Screenshot de região para clipboard |
| `SUPER + Shift + S` | Screenshot de região para clipboard |

## Wallpapers e temas

Os scripts esperam wallpapers em:

```text
~/wallpaper/
```

O wallpaper ativo deve apontar para:

```text
~/wallpaper/wallpaper.png
```

Ao escolher um wallpaper pelo Rofi, o script atualiza o symlink, aplica o
wallpaper com `awww`, regenera a paleta com `wal`, reinicia a Waybar e atualiza
SwayNC/pywalfox quando disponíveis.

## Estrutura

| Caminho | Conteúdo |
| --- | --- |
| `.config/hypr` | Configuração do Hyprland e scripts da sessão |
| `.config/waybar` | Barra superior e módulos |
| `.config/rofi` | Launcher, clipboard, wallpaper picker e scripts auxiliares |
| `.config/swaync` | Notificações e central de controle |
| `.config/wlogout` | Menu de logout/energia |
| `.config/kitty` | Terminal |
| `.config/nvim` | Neovim |
| `.config/fastfetch` | Tela de informações do sistema |
| `scripts/` | Instalador e comandos auxiliares |

## Manutenção

Após editar scripts shell, valide a sintaxe:

```bash
for f in .config/hypr/scripts/*.sh .config/waybar/script/*.sh scripts/*; do
  [ -f "$f" ] && bash -n "$f"
done
```

Antes de commitar, verifique espaços problemáticos:

```bash
git diff --check
```

## Segurança

Não execute scripts remotos diretamente com `curl | sh`. Clone o repositório,
revise os scripts e mantenha backups das configurações antigas.
