#!/bin/bash

# ==========================================
# Script Maestro de Instalación y Configuración
# Optimizado para reconstruir el entorno "sway-liviano"
# ==========================================

DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

echo "==========================================="
echo "🚀 Iniciando Instalación de sway-liviano..."
echo "==========================================="

# 1. Asegurar la presencia de 'yay' (AUR helper)
if ! command -v yay &> /dev/null; then
    echo "📦 Instalando 'yay' (AUR Helper)..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
    rm -rf /tmp/yay
else
    echo "✅ 'yay' ya está instalado."
fi

# 2. Lista de dependencias (Incluye todo lo necesario para Rofi, Tmux, Nvim, Sway, Dashboard)
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
    yazi
    jq
    greetd
    greetd-tuigreet
)

echo "🔄 Instalando/Actualizando dependencias del sistema..."
yay -S --needed --noconfirm "${DEPENDENCIES[@]}"

# 3. Función segura para respaldar y symlink / copiar
link_file() {
    local src=$1
    local dest=$2
    
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "🔄 Respaldando existente $dest a $dest.bak..."
        rm -rf "${dest}.bak" 2>/dev/null
        mv "$dest" "${dest}.bak"
    fi
    
    echo "🔗 Enlazando $src -> $dest"
    ln -sf "$src" "$dest"
}

echo "📂 Configurando directorios y symlinks..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Images/Wallpapper"
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/fish"

# 4. Enlazando los componentes del entorno
link_file "$DOTFILES_DIR/sway" "$CONFIG_DIR/sway"
link_file "$DOTFILES_DIR/hypr" "$CONFIG_DIR/hypr"     # Por si utilizas Hyprland en futuro
link_file "$DOTFILES_DIR/waybar" "$CONFIG_DIR/waybar"
link_file "$DOTFILES_DIR/swaync" "$CONFIG_DIR/swaync"
link_file "$DOTFILES_DIR/swayosd" "$CONFIG_DIR/swayosd"
link_file "$DOTFILES_DIR/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
link_file "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
link_file "$DOTFILES_DIR/rofi" "$CONFIG_DIR/rofi"
link_file "$DOTFILES_DIR/yazi" "$CONFIG_DIR/yazi" # Añadido para yazi
link_file "$DOTFILES_DIR/dashboard" "$HOME/sway-liviano/dashboard" # Mantiene rutas exactas que tienes en config
link_file "$DOTFILES_DIR/bin/micctl" "$HOME/.local/bin/micctl"

# Restaura alias si existieran
if [ -f "$DOTFILES_DIR/.bashrc" ]; then
    cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
fi
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
fi

# 5. Tmux: Instalar TPM y restaurar la configuración completa
echo "🖥️  Configurando Tmux y TPM..."
if [ -d "$DOTFILES_DIR/tmux_home_backup" ]; then
    cp -RL "$DOTFILES_DIR/tmux_home_backup" "$HOME/.tmux"
fi
link_file "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "📥 Instalando Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    # Instalar los plugins automáticos silenciados para que aplique tu tema de inmediato
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
fi

# 6. Wallpapers
echo "🌄 Restaurando Wallpapers..."
if [ -d "$DOTFILES_DIR/wallpapers_backup" ]; then
    cp -RL "$DOTFILES_DIR/wallpapers_backup/"* "$HOME/Images/Wallpapper/" 2>/dev/null
fi

# 7. Restauración de la Pantalla de Inicio de Sesión (Greetd)
if [ -d "$DOTFILES_DIR/greetd_backup" ] && [ -x "$(command -v greetd)" ]; then
    echo "⚙️  Restaurando y configurando Greetd (requiere sudo)..."
    sudo cp -RL "$DOTFILES_DIR/greetd_backup/"* /etc/greetd/ 2>/dev/null
    sudo chmod -R 755 /etc/greetd
    sudo systemctl enable greetd.service
fi

# 8. Optimizaciones del Sistema
if [ -f "$DOTFILES_DIR/sysctl/99-zram-optimization.conf" ]; then
    echo "⚙️  Aplicando optimizaciones de Zram (requiere sudo)..."
    sudo cp "$DOTFILES_DIR/sysctl/99-zram-optimization.conf" /etc/sysctl.d/
    sudo sysctl --system
fi

echo "=========================================================="
echo "✅ Instalación Exitosa!!!"
echo "🎯 Lo que debes hacer ahora:"
echo "1. Reiniciar tu máquina o iniciar sway / tu gestor de ventanas."
echo "2. Para que tmux cargue correctamente sus temas, entra a una terminal, ejecuta 'tmux' y presiona el atajo para recargar TPM o sus plugins (ej. prefix + I)."
echo "=========================================================="
