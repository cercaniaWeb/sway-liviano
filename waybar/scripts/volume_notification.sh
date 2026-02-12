#!/bin/bash

# Get current volume
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

# Notification ID to replace previous notifications
NOTIFICATION_ID=9993

if [ "$MUTED" = "MUTED" ]; then
    notify-send -t 2000 -r $NOTIFICATION_ID -u low "Volume" "Muted 🔇"
else
    # Create a progress bar
    BAR_LENGTH=20
    FILLED=$((VOLUME * BAR_LENGTH / 100))
    EMPTY=$((BAR_LENGTH - FILLED))
    BAR=$(printf '█%.0s' $(seq 1 $FILLED))$(printf '░%.0s' $(seq 1 $EMPTY))
    
    # Choose icon based on volume level
    if [ $VOLUME -ge 70 ]; then
        ICON="🔊"
    elif [ $VOLUME -ge 30 ]; then
        ICON="🔉"
    else
        ICON="🔈"
    fi
    
    notify-send -t 2000 -r $NOTIFICATION_ID -u low "Volume $ICON" "$BAR $VOLUME%"
fi
