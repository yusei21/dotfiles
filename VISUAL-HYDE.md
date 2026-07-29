# Integração visual seletiva do HyDE

Esta branch instala somente a camada visual solicitada:

- Rofi Launcher;
- seleção e importação de temas;
- seleção de wallpaper;
- Wallbash;
- aparência do Kitty;
- integração Qt/Kvantum para o Dolphin;
- suporte Wallbash para o Antigravity IDE.

A configuração principal do Hyprland não é substituída. Monitores, teclado, mouse, workspaces e preferências pessoais permanecem intactos.

## Recursos removidos

O instalador remove ou desativa:

- `swaync`, `mako`, `dunst` e `fnott`;
- central de notificações;
- menu de energia/logout;
- `lf`;
- hibernação;
- ações automáticas por inatividade.

O `hypridle` é encerrado e mascarado, e referências de autostart são removidas. Assim, o computador não bloqueia, suspende, hiberna ou desliga automaticamente por falta de atividade.

A suspensão manual continua disponível. A hibernação permanece mascarada por decisão desta branch.

## Instalação

Na raiz do repositório:

```bash
chmod +x scripts/install-visual-hyde.sh
./scripts/install-visual-hyde.sh
```

Antes das alterações, o script cria um backup em:

```text
~/.local/state/visual-hyde-backup/
```

## Atalhos

Os arquivos de atalhos não são substituídos integralmente. O instalador apenas garante:

```ini
bind = $mainMod, E, exec, dolphin
```

Os atalhos dos seletores de tema, wallpaper e launcher podem ser associados manualmente.

## Temas

Para importar temas:

```bash
hyde-shell pyinit
hyde-shell theme.import --select
```

Para trocar o tema instalado:

```bash
hyde-shell theme.select
```

Para aplicar Wallbash aos aplicativos:

```bash
hyde-shell wallbash kitty
hyde-shell wallbash qtct
hyde-shell wallbash code
hyde-shell wallbash chrome
```

## Reinstalação

Depois de formatar o sistema e clonar o repositório, execute novamente o instalador. Ele reinstala a camada visual, restaura os ajustes seletivos e mantém notificações, hibernação e ações automáticas por inatividade desativadas.
