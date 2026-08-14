#!/usr/bin/env bash
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
desktop_image="$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"

if [[ ! -f "$desktop_image" ]]; then
    desktop_image="$HOME/.config/rofi/current_wallpaper.png"
fi

ln -snf "$desktop_image" "$HOME/.config/rofi/current_wallpaper.png"

rofi "$@" \
  -config "$HOME/.config/rofi/master_theme.rasi" \
  -theme-str "window { background-image: url(\"${desktop_image}\"); } mainbox { background-color: transparent; } inputbar { background-color: transparent; }"
