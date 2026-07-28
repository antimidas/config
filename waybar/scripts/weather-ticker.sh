#!/bin/bash

# Setup temporary state storage files
CACHE_FILE="/tmp/wttr_cache"
INDEX_FILE="/tmp/wttr_index"
DISPLAY_LEN=15

# 1. Fetch weather if the cache is missing or older than 15 minutes
if [ ! -f "$CACHE_FILE" ] || [ $(find "$CACHE_FILE" -mmin +15) ]; then
    WEATHER_DATA=$(wttrbar --date-format "%m-%d" 2>/dev/null | jq -r '.text')
    
    # Fallback string if internet or wttrbar fails
    if [ -z "$WEATHER_DATA" ] || [ "$WEATHER_DATA" == "null" ]; then
        WEATHER_DATA="Weather Unavailable"
    fi
    # Add trailing spaces so the end loops cleanly back to the front
    echo "$WEATHER_DATA        " > "$CACHE_FILE"
    echo "0" > "$INDEX_FILE"
fi

# 2. Read current text and animation frame index
TEXT=$(cat "$CACHE_FILE")
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)
TEXT_LEN=${#TEXT}

# 3. Slice the text based on current index position
if [ "$TEXT_LEN" -le "$DISPLAY_LEN" ]; then
    # No scroll needed if the string fits the window perfectly
    echo "$TEXT"
else
    # Generate the scrolling window slice
    SLICED_TEXT="${TEXT:$INDEX:$DISPLAY_LEN}"
    
    # Pad text if the slice hits the end string boundary
    if [ ${#SLICED_TEXT} -lt "$DISPLAY_LEN" ]; then
        REMINDER=$((DISPLAY_LEN - ${#SLICED_TEXT}))
        SLICED_TEXT="${SLICED_TEXT}${TEXT:0:$REMINDER}"
    fi
    
    echo "$SLICED_TEXT"
    
    # Increment position marker for the next second interval sweep
    NEXT_INDEX=$(( (INDEX + 1) % TEXT_LEN ))
    echo "$NEXT_INDEX" > "$INDEX_FILE"
fi
