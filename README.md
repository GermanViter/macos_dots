# Dotfiles

Personal configuration files and environment settings for macOS and Linux. 
> Some apps work better with MacOs like AeroSpace so if you are on Linux, just delete those folders before running the script. The rest of the configs should work fine on both platforms.

## Contents
- [Overview](#overview)
- [Screenshots](#screenshots)
- [Managed Applications](#managed-applications)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Script Options](#script-options)
- [Theme Switcher](#theme-switcher)
- [How it Works](#how-it-works)
- [Troubleshooting](#troubleshooting)
- [Adding New Configs](#adding-new-configs)

## Overview

This repository uses a modular structure where each directory represents an application or tool. A central setup script manages the creation of symbolic links from the repository to your home directory and `~/.config` folder, and handles system dependencies via Homebrew.

## Screenshots

<ul align="center">
  <li><h3>Hyprland</h3><img src="assets/hyprland.png" width="400" /></li>
  <li><h3>Hyprlock</h3><img src="assets/hyprlock.png" width="400" /></li>
  <li><h3>Neovim</h3><img src="assets/neovim.png" width="400" /></li>
  <li><h3>Yazi</h3><img src="assets/yazi.png" width="400" /></li>
</ul>

> [!TIP]
> Checkout my wallpapers on [GermanViter/wallpapers](https://github.com/GermanViter/wallpapers).

## Managed Applications

- **Terminal/Shell**: [Fish](https://fishshell.com/), [Zsh](https://www.zsh.org/), [Tmux](https://github.com/tmux/tmux)
- **Editors**: [Neovim](https://neovim.io/) (LazyVim), [Zed](https://zed.dev/)
- **Prompt**: [Starship](https://starship.rs/)
- **UI/Window Management**: [Aerospace](https://github.com/nikitabobko/AeroSpace), [Ghostty](https://ghostty.org/), [Kitty](https://sw.kovidgoyal.net/kitty/), [Alacritty](https://alacritty.org/)
- **CLI Tools**: [Fastfetch](https://github.com/fastfetch-cli/fastfetch), [Bat](https://github.com/sharkdp/bat), [Yazi](https://github.com/sxyazi/yazi)
- **Package Management**: [Homebrew](https://brew.sh/) (via Brewfile)
- **Others**: Macmon

## Local Overrides

To add private configurations (like work-specific paths or API keys) without committing them to the repository, use local override files:
- **Zsh**: Create `~/.zshrc.local`
- **Brew**: Create `~/.Brewfile.local` (Note: ensure your script supports this if you implement it)

These files are ignored by Git.

## Dependencies
- Homebrew (for package management)
- Git (for cloning the repository)
- Zsh (for shell configurations)
- GNU Stow (for setting up the symlinks)

## Installation

To apply these configurations to a new system:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   ```

2. **Run the setup script:**
   The script uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks. It will automatically detect packages in the repository and link them to your home directory.

   ```bash
   # Install dependencies (Homebrew & Stow) first if needed, 
   # or run with --brew to handle it via the script.
   ~/.dotfiles/scripts/setup_symlinks.sh --brew
   ```

### Script Options

- `(no arguments)`: Creates symlinks using `stow`.
- `--brew`: Installs all packages listed in `brew/.Brewfile` using Homebrew.
- `--dry-run`: Simulates the process without making any changes.
- `--unlink`: Removes the symlinks (unstow).
- `--help`: Displays help information.

## Theme Switcher

The `scripts/switch-theme.sh` script allows you to quickly switch between different color schemes across multiple applications (Ghostty, Kitty, Neovim, and Starship).

### Usage
```bash
~/.dotfiles/scripts/switch-theme.sh [main|moon|dawn|catppuccin|black|gruvbox]
```

### Supported Themes
- **main**: Rosé Pine (Default)
- **moon**: Rosé Pine Moon
- **dawn**: Rosé Pine Dawn
- **catppuccin**: Catppuccin Mocha
- **black**: Black Metal Gorgoroth
- **gruvbox**: Gruvbox Dark

### What it updates:
- **Ghostty**: Updates the `theme` setting in `ghostty/config`.
- **Kitty**: Uses the themes kitten to reload all active instances.
- **Neovim**: Updates a local state file to switch between Rosé Pine variants or the Catppuccin plugin.
- **Starship**: Symlinks the appropriate `.toml` config.
- **Yazi**: Symlinks the appropriate `.toml` theme file.
- **Tmux**: Symlinks the appropriate `.tmux` theme file and reloads the config.
- **Wallpaper**: Changes the system wallpaper (**macOS and Linux support**).

### Modifying wallpapers
To add new wallpapers, add an image to assets/wallpapers/ and update the `WALLPAPER` variable in the `switch case` section for the theme you want. The script supports macOS, Wayland, and X11 wallpaper tools.

---

## How it Works

The `scripts/setup_symlinks.sh` script is a wrapper around `stow`:

1. **Modular Packages**: Each top-level directory (e.g., `nvim`, `zsh`, `fish`) is treated as a "stow package".
2. **Mirroring**: Stow mirrors the internal structure of these directories into your `$HOME`.
   - `zsh/.zshrc` becomes `~/.zshrc`
   - `nvim/.config/nvim/` becomes `~/.config/nvim/`
3. **Safety**: Stow will not overwrite existing real files. It only creates symlinks. If a file already exists, it will report a conflict.
4. **Homebrew Integration**: The `--brew` flag uses `brew bundle` on the `brew/.Brewfile`.

## Updating configurations
To update your configurations after pulling new changes from the repository:
1. Pull the latest changes:
   ```bash
   git pull
   ```
2. Re-run the setup script to apply any new symlinks:
   ```bash
   ~/.dotfiles/scripts/setup_symlinks.sh
   ```

## Troubleshooting
- If you can't run the script, ensure it has execute permissions:
  ```bash
  chmod +x ~/.dotfiles/scripts/setup_symlinks.sh
  ```
- If you encounter issues with symlinks, check the backup directory for any files that were moved.
- Ensure you have Homebrew installed if you plan to use the `--brew` option.
- For any application-specific issues, refer to the respective application's documentation or open an issue in this repository.

## Adding New Configs

To add a new application to this repo:
1. **Create a folder** named after the application (e.g., `tmux`). 
   - *Note: Avoid reserved names like `scripts`, `assets`, or `gemini` as the script is configured to ignore them.*
   - *Note: Do not start the folder name with a dot (use `zsh/`, not `.zsh/`).*
2. **Mirror the destination structure** inside that folder:
   - If the config belongs in `~/.config/app/config`, create `app/.config/app/config`.
   - If the config belongs in `~/.apprc`, create `app/.apprc`.
3. **Run the setup script** to apply the changes:
   ```bash
   ./scripts/setup_symlinks.sh
   ```
