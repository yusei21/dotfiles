# Hyprland Dotfiles

[🇧🇷 Português](README.pt-BR.md)

Personal CachyOS/Arch setup using Hyprland, Waybar, Rofi, SwayNC,
Kitty, Neovim, Fastfetch, Fish/Zsh, and visual integration with pywal/Wallbash.

## Main features

- Hyprland with keybindings organized by category.
- Compact Waybar with workspaces, clock, recording, battery, Bluetooth, and network.
- Rofi for application launching, clipboard, Wi-Fi, and wallpaper selection.
- Styled SwayNC for notifications and the control center.
- Kitty with dynamic pywal theming.
- Scripts for wallpapers, themes, volume, brightness, screenshots, recording, and battery.
- Optional installer for selected visual components from HyDE.

## Requirements

This setup is designed for Arch Linux/CachyOS running a Wayland session. Before installing,
make sure the main packages are available:

```bash
sudo pacman -S --needed \
  git rsync hyprland waybar rofi kitty swaync hyprlock hypridle \
  pywal imagemagick jq brightnessctl pamixer playerctl wl-clipboard cliphist \
  hyprshot awww dolphin fastfetch
```

Some features are optional and only work when the corresponding package is installed:

- `bluetooth`/`bluetui` for the Bluetooth module.
- `spotify` and Spicetify for Spotify theming.
- `antigravity-ide` for the IDE shortcut and visual integration.
- `con` (Con Terminal) for the `SUPER + Shift + T` shortcut.
- Nerd Fonts used by the themes, especially `DepartureMono Nerd Font`.

## Quick installation

Clone the repository:

```bash
git clone https://github.com/yusei21/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Back up your current configuration:

```bash
mkdir -p ~/.local/state/dotfiles-backup
cp -a ~/.config ~/.zshrc ~/.local/state/dotfiles-backup/ 2>/dev/null || true
```

Copy the configuration files:

```bash
rsync -av --exclude='.git' .config/ ~/.config/
cp -f .zshrc ~/.zshrc
```

Create the wallpaper directory and set an initial wallpaper:

```bash
mkdir -p ~/wallpaper
cp /path/to/your/wallpaper.png ~/wallpaper/wallpaper.png
```

Reload Hyprland or restart your session:

```bash
hyprctl reload
```

## HyDE visual layer installation

This repository includes an optional installer that imports only selected visual parts
of HyDE without replacing the personal Hyprland base configuration.

Read the script before running it:

```bash
sed -n '1,260p' scripts/install-visual-hyde.sh
```

Run it:

```bash
chmod +x scripts/install-visual-hyde.sh
./scripts/install-visual-hyde.sh
```

The installer creates backups in:

```text
~/.local/state/visual-hyde-backup/
```

After installation, use:

```bash
select-hyde-theme
sync-wallbash-theme
```

## Useful keybindings

| Keybinding | Action |
| --- | --- |
| `SUPER + Space` | Open Rofi |
| `SUPER + T` | Open Kitty |
| `SUPER + Shift + T` | Open Con Terminal |
| `SUPER + Return` | Open Kitty |
| `SUPER + Shift + Return` | Open floating Kitty |
| `SUPER + E` | Open Dolphin |
| `SUPER + W` | Open browser |
| `SUPER + A` | Select wallpaper |
| `SUPER + B` | Switch to a random wallpaper |
| `SUPER + R` | Start/stop recording |
| `SUPER + L` | Lock session |
| `SUPER + Shift + R` | Reload Hyprland |
| `SUPER + Shift + O` | Restart Waybar |
| `SUPER + Shift + V` | Open clipboard manager |
| `Print` | Screenshot current monitor to clipboard |
| `Ctrl + Print` | Screenshot selected region to clipboard |
| `SUPER + Shift + S` | Screenshot selected region to clipboard |

## Wallpapers and themes

The scripts expect wallpapers in:

```text
~/wallpaper/
```

The active wallpaper should point to:

```text
~/wallpaper/wallpaper.png
```

When selecting a wallpaper through Rofi, the script updates the symlink, applies the
wallpaper with `awww`, regenerates the palette with `wal`, restarts Waybar, and updates
SwayNC/pywalfox when available.

## Repository structure

| Path | Description |
| --- | --- |
| `.config/hypr` | Hyprland configuration and session scripts |
| `.config/waybar` | Top bar and modules |
| `.config/rofi` | Launcher, clipboard, wallpaper picker, and helper scripts |
| `.config/swaync` | Notifications and control center |
| `.config/wlogout` | Logout and power menu |
| `.config/kitty` | Terminal |
| `.config/nvim` | Neovim |
| `.config/fastfetch` | System information screen |
| `scripts/` | Installer and helper commands |

## Maintenance

After editing shell scripts, validate their syntax:

```bash
for f in .config/hypr/scripts/*.sh .config/waybar/script/*.sh scripts/*; do
  [ -f "$f" ] && bash -n "$f"
done
```

Before committing, check for whitespace problems:

```bash
git diff --check
```

## Security

Do not run remote scripts directly with `curl | sh`. Clone the repository,
review the scripts, and keep backups of your previous configuration.
