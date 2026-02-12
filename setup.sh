#!/bin/bash

# ==========================================
# Catppuccin Dotfiles Setup Script
# ==========================================

DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

echo "🚀 Starting Dotfiles Installation..."

# Function to create symbolic links
link_file() {
    local src=$1
    local dest=$2
    
    if [ -e "$dest" ]; then
        echo "🔄 Backing up existing $dest..."
        mv "$dest" "$dest.bak"
    fi
    
    echo "🔗 Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# Create directories
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/.local/bin"

# Apply links
link_file "$DOTFILES_DIR/sway" "$CONFIG_DIR/sway"
link_file "$DOTFILES_DIR/waybar" "$CONFIG_DIR/waybar"
link_file "$DOTFILES_DIR/swaync" "$CONFIG_DIR/swaync"
link_file "$DOTFILES_DIR/swayosd" "$CONFIG_DIR/swayosd"
link_file "$DOTFILES_DIR/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
link_file "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
link_file "$DOTFILES_DIR/dashboard" "$HOME/.dashboard"
link_file "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/bin/micctl" "$HOME/.local/bin/micctl"

# Apply system tweaks (requires sudo)
if [ -f "$DOTFILES_DIR/sysctl/99-zram-optimization.conf" ]; then
    echo "⚙️  Applying Zram optimizations (requires sudo)..."
    sudo cp "$DOTFILES_DIR/sysctl/99-zram-optimization.conf" /etc/sysctl.d/
    sudo sysctl --system
fi

echo "✅ Setup complete! Please reload your window manager."
