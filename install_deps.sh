#!/bin/bash

# ==========================================
# Script de Instalación de Dependencias
# Optimizado para sway-liviano
# ==========================================

echo "📦 Instalando dependencias necesarias para el entorno..."

# Asegurarse de tener un helper de AUR (yay)
if ! command -v yay >/dev/null 2>&1; then
    echo "❌ yay no encontrado. Por favor instala yay primero."
    exit 1
fi

# Lista de paquetes esenciales extraídos del sistema actual
DEPENDENCIES=(
    sway
    swaybg
    swayidle
    swaylock
    waybar
    swaync
    swayosd-git
    rofi-wayland
    alacritty
    ghostty
    fish
    starship
    tmux
    neovim
    grim
    slurp
    wl-clipboard
    cliphist
    brightnessctl
    pavucontrol
    pamixer
    playerctl
    nm-connection-editor
    network-manager-applet
    ttf-jetbrains-mono-nerd
    zram-generator
    thorium-browser-bin
    eza
    bat
    fzf
    zoxide
    bottom
)

echo "🔄 Actualizando e instalando paquetes..."
yay -S --noconfirm --needed ${DEPENDENCIES[@]}

echo "✅ Instalación de dependencias completada."
