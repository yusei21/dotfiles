# Dotfiles v2
CachyOS / Hyprland 0.57 desktop for AI engineering.

[Português](README.pt-BR.md)

Development snapshot: test in a disposable session before replacing a working desktop. Run `bash install.sh --dry-run`, then `bash install.sh` after reviewing the package list. Existing configs are backed up. Set Fish as your login shell manually with `chsh -s /usr/bin/fish` if desired. On tty1 Fish starts Hyprland automatically. Put images in ~/Pictures/Wallpapers/{horizontal,vertical}. The desktop uses a fixed monochrome theme; wallpaper changes never alter colors. Super+Enter / Super+Alt+Enter cycle; add Shift to select. Super+T terminal, Super+W Brave Origin, Super+Shift+W LibreWolf. Docker and Ollama are not enabled by this installer. External applications and agent packages require manual verification; see packages/optional.txt. No credentials belong here.
