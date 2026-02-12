#!/bin/bash

# Path to the Obsidian vault - User should adjust this if it's different
VAULT_PATH="/home/lro/Documents/Obsidian Vault"

# Check if obsidian is installed
if ! command -v obsidian &> /dev/null; then
    swaynag -t error -m "Obsidian is not installed. Please install it to use the dashboard."
    exit 1
fi

# Create vault directory if it doesn't exist
mkdir -p "$VAULT_PATH"

# Launch obsidian with the specific vault directly
obsidian "$VAULT_PATH" &

# Give it a second to open then we apply window rules via Sway (handled in sway/config)
