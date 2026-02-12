#!/bin/bash
THEME_FILE="$HOME/.config/waybar/theme.css"
FULL_THEME="$HOME/.config/waybar/themes/full.css"
CAPSULE_THEME="$HOME/.config/waybar/themes/capsules.css"

if diff "$THEME_FILE" "$FULL_THEME" >/dev/null; then
    cp "$CAPSULE_THEME" "$THEME_FILE"
else
    cp "$FULL_THEME" "$THEME_FILE"
fi
pkill -USR2 waybar
