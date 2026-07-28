#!/usr/bin/env bash

TERMINAL_CMD="${1:-kitty}"
CLASS_NAME="dropdown_term"

if [[ "$TERMINAL_CMD" == *"kitty"* ]] && [[ "$TERMINAL_CMD" != *"--class"* ]]; then
    TERMINAL_CMD="$TERMINAL_CMD --class $CLASS_NAME"
fi

WINDOW_ADDR=$(hyprctl clients -j | jq -r --arg CLASS "$CLASS_NAME" '.[] | select(.class == $CLASS) | .address' | head -n 1)

if [ -z "$WINDOW_ADDR" ] || [ "$WINDOW_ADDR" = "null" ]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"[float; size 1200 700; center] $TERMINAL_CMD\")"
    
    for i in {1..20}; do
        sleep 0.1
        WINDOW_ADDR=$(hyprctl clients -j | jq -r --arg CLASS "$CLASS_NAME" '.[] | select(.class == $CLASS) | .address' | head -n 1)
        if [ -n "$WINDOW_ADDR" ] && [ "$WINDOW_ADDR" != "null" ]; then
            break
        fi
    done

    if [ -n "$WINDOW_ADDR" ] && [ "$WINDOW_ADDR" != "null" ]; then
        hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:dropdown', window = 'address:$WINDOW_ADDR' })"
        hyprctl dispatch "hl.dsp.workspace.toggle_special('dropdown')"
    fi
else
    ACTIVE_SPECIAL=$(hyprctl monitors -j | jq -r '.[0].specialWorkspace.name')
    
    if [ "$ACTIVE_SPECIAL" = "special:dropdown" ]; then
        hyprctl dispatch "hl.dsp.workspace.toggle_special('dropdown')"
    else
        hyprctl dispatch "hl.dsp.workspace.toggle_special('dropdown')"
        hyprctl dispatch "hl.dsp.window.focus({ window = 'address:$WINDOW_ADDR' })"
    fi
fi
