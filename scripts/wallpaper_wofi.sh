#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers" # adapte le chemin

# Vérifie que swww-daemon tourne
if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Liste les images et affiche via wofi
SELECTED=$(
    find "$WALLPAPER_DIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" \
        -o -iname "*.png" -o -iname "*.gif" \
        -o -iname "*.webp"
) | sort | xargs -I{} basename {} |
    wofi --dmenu \
        --prompt "Wallpaper" \
        --insensitive \
        --cache-file /dev/null

# Si rien sélectionné, on quitte
[ -z "$SELECTED" ] && exit 0

# Applique avec une transition sympa
swww img "$WALLPAPER_DIR/$SELECTED" \
    --transition-type grow \
    --transition-pos "$(hyprctl cursorpos)" \
    --transition-duration 1.5 \
    --transition-fps 60
