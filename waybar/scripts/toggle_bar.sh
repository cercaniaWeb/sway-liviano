#!/bin/bash

STYLE_FILE="$HOME/.config/waybar/style.css"

if grep -q "background: none !important; /* TOGGLE_STATE */" "$STYLE_FILE"; then
    # Volver al estado con fondo
    sed -i "s/background: none !important; \/* TOGGLE_STATE *\//background: rgba(30, 30, 46, 0.4);/" "$STYLE_FILE"
    sed -i "s/border-bottom: none !important; \/* TOGGLE_STATE *\//border-bottom: 2px solid rgba(180, 190, 254, 0.2);/" "$STYLE_FILE"
else
    # Quitar fondo (modo cápsulas)
    sed -i "s/background: rgba(30, 30, 46, 0.4);/background: none !important; \/* TOGGLE_STATE *\//" "$STYLE_FILE"
    sed -i "s/border-bottom: 2px solid rgba(180, 190, 254, 0.2);/border-bottom: none !important; \/* TOGGLE_STATE *\//" "$STYLE_FILE"
fi

pkill -USR2 waybar
