#!/bin/bash

CONFIG_FILE="/home/lro/.config/swaync/config.json"
SCRIPTS_DIR="/home/lro/.config/swaync/scripts"

while true; do
    # Get current stats
    CPU=$($SCRIPTS_DIR/cpu_usage.sh)
    RAM=$($SCRIPTS_DIR/ram_usage.sh)
    TEMP=$($SCRIPTS_DIR/temp.sh)

    # Update the config file using sed
    # We target the specific lines for label#cpu, label#ram, label#temp
    # This is a bit fragile but works for personal setups
    # Update the config file using sed
    # We target the specific lines for label#system_stats
    # STATS_TEXT="󰻠 CPU $CPU  |  󰍛 RAM $RAM  |  󰏈 TEMP $TEMP"
    # sed -i "/\"label#system_stats\": {/,/}/ s/\"text\": \".*\"/\"text\": \"$STATS_TEXT\"/" "$CONFIG_FILE"

    # Reload SwayNC configuration
    # swaync-client -R
    
    # Update every 5 seconds to be gentle on resources
    sleep 3600
done
