# Dotfiles: HyDE com personalizacoes

Esta branch substitui a colecao anterior de dotfiles por [HyDE](https://github.com/HyDE-Project/HyDE), fixado como submodulo Git para manter a origem e permitir atualizacoes separadas.

## Preservado da configuracao anterior

| Saida | Resolucao / frequencia | Posicao | Escala |
| --- | --- | --- | --- |
| HDMI-A-1 | 1920x1080@119.98 | 0x0 | 1 |
| DP-3 | 1920x1080@239.96 | 1920x0 | 1 |

A configuracao original usava **239,96 Hz**, nao 244 Hz. Mantivemos exatamente a taxa existente para nao presumir que 244 Hz e suportado.

- **Super + T:** abre Kitty.
- **Super + Q:** fecha a janela ativa.

As personalizacoes ficam em `overrides/hyprland.lua`, carregadas como override apos a instalacao do HyDE.

## Instalacao (Arch Linux)

```bash
git clone --recurse-submodules https://github.com/yusei21/dotfiles.git
cd dotfiles
bash ./setup.sh
```

**Importante:** executar o instalador oficial do HyDE pode instalar pacotes e mudar configuracoes do sistema. Leia `HyDE/Scripts/install.sh` antes de executar. O `setup.sh` faz backup do `hyprland.lua` atual, invoca o instalador e aplica as personalizacoes somente se a instalacao terminar com sucesso. Para apenas restaurar configuracoes, use `bash ./setup.sh -r`.

Caso ja tenha clonado sem submodulos:

```bash
git submodule update --init --recursive
```

As mudancas desta branch **nao instalam nada automaticamente no seu computador**. Se estiver revisando o pull request, substitua `main` pela branch de migracao no clone antes de instalar.
