#!/bin/bash
THEME_FILE="/home/lro/.config/waybar/theme.css"
FULL_THEME="/home/lro/.config/waybar/themes/full.css"
CAPSULE_THEME="/home/lro/.config/waybar/themes/capsules.css"

if /usr/bin/diff "$THEME_FILE" "$FULL_THEME" >/dev/null; then
    /usr/bin/cp "$CAPSULE_THEME" "$THEME_FILE"
else
    /usr/bin/cp "$FULL_THEME" "$THEME_FILE"
fi

/usr/bin/pkill -USR2 waybar
