# Integração visual seletiva do HyDE

Esta branch adiciona somente os componentes visuais solicitados:

- Rofi Launcher e layouts do HyDE;
- Theme Select;
- Wallpaper Select;
- Launcher Select;
- Wallbash Modes;
- aparência dinâmica do Kitty;
- integração Wallbash com o Antigravity IDE;
- integração Wallbash com o Spotify;
- integração visual Qt/Kvantum para o Dolphin.

A integração não substitui a configuração principal do Hyprland. Permanecem intactos:

- monitores;
- teclado e mouse;
- workspaces;
- regras e preferências pessoais do Hyprland.

## Tema sincronizado

O instalador adiciona dois comandos:

```bash
select-hyde-theme
sync-wallbash-theme
```

Use `select-hyde-theme` para escolher um tema e sincronizar a paleta gerada pelo Wallbash com:

- Kitty;
- Antigravity IDE;
- Spotify.

O comando `sync-wallbash-theme` reaplica a paleta atual sem abrir o seletor. O Spotify não precisa aplicar o tema ao ser aberto pelo atalho; a sincronização ocorre apenas quando um desses comandos é executado.

## Notificações

O instalador remove referências e bloqueia os serviços comuns de notificação:

- `swaync`;
- `mako`;
- `dunst`;
- `fnott`.

## Inatividade e energia

O `hypridle` é encerrado, desativado e mascarado. Assim, não há bloqueio, suspensão ou desligamento automático por inatividade.

O instalador também mascara:

- `hibernate.target`;
- `hybrid-sleep.target`;
- `suspend-then-hibernate.target`.

A suspensão manual continua disponível.

## Instalação

Na raiz do repositório:

```bash
chmod +x scripts/install-visual-hyde.sh
./scripts/install-visual-hyde.sh
```

Antes de copiar os componentes, o script cria um backup em:

```text
~/.local/state/visual-hyde-backup/
```

## Atalhos

O instalador define o Dolphin no `SUPER+E`. Os demais atalhos pessoais continuam preservados.

## Reinstalação após formatação

Depois de instalar o Arch e clonar este repositório, execute novamente o instalador. Ele restaura a camada visual, instala os comandos de sincronização, desativa notificações, impede ações automáticas por inatividade e mantém a hibernação desativada.
