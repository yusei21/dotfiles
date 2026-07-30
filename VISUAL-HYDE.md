# Integração visual seletiva do HyDE

Esta configuração adiciona componentes visuais selecionados do HyDE:

- Rofi Launcher e layouts do HyDE;
- Theme Select;
- Wallpaper Select;
- Launcher Select;
- Wallbash Modes;
- aparência dinâmica do Kitty;
- integração Wallbash com o Antigravity IDE;
- integração Wallbash com o Spotify;
- integração visual Qt/Kvantum para o Dolphin.

A integração preserva as configurações principais de monitores, teclado, mouse, workspaces e regras pessoais do Hyprland.

## Aviso antes da instalação

O instalador modifica o sistema e deve ser revisado antes da execução. Ele:

- usa `sudo`;
- instala e pode remover pacotes;
- substitui arquivos de configuração do usuário;
- desativa servidores de notificação;
- desativa ações automáticas do `hypridle`;
- mascara alvos de hibernação;
- cria um backup antes das alterações.

Não execute o script diretamente de uma URL. Clone o repositório, leia `scripts/install-visual-hyde.sh` e somente depois execute-o.

## Tema sincronizado

O instalador adiciona dois comandos:

```bash
select-hyde-theme
sync-wallbash-theme
```

Use `select-hyde-theme` para escolher um tema e sincronizar a paleta gerada pelo Wallbash com Kitty, Antigravity IDE e Spotify.

O comando `sync-wallbash-theme` reaplica a paleta atual sem abrir o seletor. O arquivo de cores é validado como dados e não é executado como código shell.

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

Depois de instalar o Arch e clonar este repositório, revise o instalador e execute-o novamente. Ele restaura a camada visual, instala os comandos de sincronização, desativa notificações, impede ações automáticas por inatividade e mantém a hibernação desativada.
