#!/usr/bin/env bash

# theme-selector.sh - A Rofi/Wofi menu for switching themes

# Define themes (matching the keys in switch-theme.sh)
themes="main
moon
dawn
catppuccin
black
gruvbox"

# Determine which menu tool to use
if command -v wofi >/dev/null 2>&1; then
    # Use wofi (default for your Hyprland setup)
    selected=$(echo -e "$themes" | wofi --dmenu --prompt "Select Theme:" --width 300 --height 300 --cache-file /dev/null)
elif command -v rofi >/dev/null 2>&1; then
    # Fallback to rofi if installed
    selected=$(echo -e "$themes" | rofi -dmenu -i -p "Select Theme:")
else
    echo "Error: Neither wofi nor rofi found."
    exit 1
fi

# If a theme was selected, apply it
if [[ -n "$selected" ]]; then
    # Ensure we use the absolute path to the switch-theme script
    "$(dirname "$0")/switch-theme.sh" "$selected"
fi
