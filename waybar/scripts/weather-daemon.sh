#!/bin/bash

OUTPUT_FILE="/tmp/waybar_weather_scroll"
DISPLAY_LEN=15
DELAY=0.25

# Clear previous runtime files
echo "" > "$OUTPUT_FILE"

while true; do
    # 1. Fetch live weather once every 15 minutes
    WEATHER_DATA=$(curl -s "https://wttr.in" | tr -d '\n')
    
    # Fallback string
    if [ -z "$WEATHER_DATA" ] || [[ "$WEATHER_DATA" == *"<!DOCTYPE"* ]]; then
        WEATHER_DATA="    Weather Offline "
    fi
    
    # Pad string for smooth rolling
    TEXT="$WEATHER_DATA       "
    TEXT_LEN=${#TEXT}
    INDEX=0

    # 2. Internal loop shifts characters locally at high speed
    # Loops for 15 minutes (900 seconds) before re-fetching from API
    for ((i=0; i<3600; i++)); do
        SLICED="${TEXT:$INDEX:$DISPLAY_LEN}"
        
        # If slice runs past the length of the string, wrap it around
        if [ ${#SLICED} -lt $DISPLAY_LEN ]; then
            REMAIN=$((DISPLAY_LEN - ${#SLICED}))
            SLICED="${SLICED}${TEXT:0:$REMAIN}"
        fi
        
        # Write directly to shared memory
        echo "$SLICED" > "$OUTPUT_FILE"
        
        INDEX=$(( (INDEX + 1) % TEXT_LEN ))
        sleep $DELAY
    done
done
