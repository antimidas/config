#!/usr/bin/env bash

# Find focused monitor name safely
m=$(hyprctl monitors -j | jq -r ".[] | select(.focused) | .name")

img="$HOME/.config/rofi/current_desktop_image_$m.png"
[[ ! -f "$img" ]] && img="$HOME/.config/rofi/current_wallpaper.png"
ln -sf "$img" "$HOME/.config/rofi/current_wallpaper.png"

chosen=$(echo -e "\n\n\n" | rofi -dmenu -p "Power" \
  -theme "$HOME/.config/rofi/power_theme.rasi" \
  -theme-str "inputbar { background-image: url(\"$img\", width); }")

case $chosen in
    "") hyprlock ;;
    "") uwsm stop ;;
    "") systemctl reboot ;;
    "") systemctl poweroff ;;
esac
