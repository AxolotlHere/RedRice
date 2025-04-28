#!/bin/bash

# Check if any MPRIS player exists
player_status=$(playerctl --list-all 2>/dev/null)

if [ -z "$player_status" ]; then
    echo '{"text": "Play a song", "class": "stopped"}'
else
    metadata=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)
    status=$(playerctl status 2>/dev/null)

    if [[ "$status" == "Playing" ]]; then
        echo "{\"text\": \"$metadata\", \"class\": \"playing\"}"
    elif [[ "$status" == "Paused" ]]; then
        echo "{\"text\": \"$metadata (paused)\", \"class\": \"paused\"}"
    else
        echo '{"text": "Play a song", "class": "stopped"}'
    fi
fi

