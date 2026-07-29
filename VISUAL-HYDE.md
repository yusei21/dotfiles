# Integração visual seletiva do HyDE

Esta branch adiciona somente os componentes visuais solicitados:

- Rofi Launcher e os layouts do HyDE;
- Theme Select;
- Wallpaper Select;
- Launcher Select;
- Wallbash Modes;
- aparência do Kitty;
- integração visual Qt/Kvantum para o Dolphin.

A integração não copia a configuração do Hyprland fornecida pelo HyDE. Assim, permanecem intactos:

- monitores;
- atalhos;
- teclado e mouse;
- workspaces;
- regras e preferências pessoais do Hyprland.

## Notificações

O `swaync` foi removido do autostart do Hyprstellar. O instalador também encerra uma instância existente. O módulo **Notification Action** do HyDE não é instalado nem configurado.

## Hibernação

O instalador mascara:

- `hibernate.target`;
- `hybrid-sleep.target`;
- `suspend-then-hibernate.target`.

A suspensão normal continua disponível.

## Instalação

Na raiz do repositório:

```bash
chmod +x scripts/install-visual-hyde.sh
./scripts/install-visual-hyde.sh
```

Antes de copiar os componentes visuais, o script cria um backup em:

```text
~/.local/state/visual-hyde-backup/
```

## Atalhos

Os arquivos de atalhos não são substituídos. Depois da instalação, os seletores do HyDE podem precisar ser associados manualmente aos atalhos que você escolher.

## Reinstalação após formatação

Depois de instalar o Arch e clonar este repositório, execute novamente o instalador. Ele reinstala os pacotes visuais, restaura os componentes escolhidos e desativa a hibernação.
