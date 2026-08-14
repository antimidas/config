#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */
# Interactive Wallpaper Selection Script (Images & Videos)

terminal=kitty
PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
wallDIR="$PICTURES_DIR/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Directory for swaync notifications
iDIR="$HOME/.config/swaync/images"
iDIRi="$HOME/.config/swaync/icons"

# SWWW transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if ! command -v bc &>/dev/null; then
  notify-send -i "$iDIR/error.png" "bc missing" "Install package bc first"
  exit 1
fi

rofi_theme="$HOME/.config/rofi/master_theme.rasi"
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

if [[ -z "$focused_monitor" ]]; then
  notify-send -i "$iDIR/error.png" "Error" "Could not detect focused monitor"
  exit 1
fi

# Target monitor-specific desktop image file sync
monitor_image="$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"

if [[ ! -f "$monitor_image" ]]; then
  if [[ -f "$HOME/.config/rofi/current_wallpaper.png" ]]; then
    ln -snf "$(readlink -f "$HOME/.config/rofi/current_wallpaper.png")" "$monitor_image"
  fi
fi

if [[ -f "$monitor_image" ]]; then
  ln -snf "$monitor_image" "$HOME/.config/rofi/current_wallpaper.png"
fi

# Rofi UI scale calculations
scale_factor=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .scale')
monitor_height=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .height')

icon_size_px=$(echo "scale=0; ($monitor_height / 9) / $scale_factor" | bc)

# Rofi CSS override with background-image removed (normal inside)
rofi_override="
window {
    width: 85%;
    height: 85%;
    fullscreen: false;
}
listview {
    columns: 5;
    lines: 3;
    fixed-columns: true;
    fixed-lines: true;
    spacing: 25px;
    layout: vertical;
    flow: horizontal;
}
element {
    orientation: vertical;
    padding: 5px;
    border-radius: 12px;
}
element-icon {
    size: ${icon_size_px}px;
    cursor: pointer;
}
element-text {
    horizontal-align: 0.5;
    vertical-align: 0.5;
    margin: 5px 0px 0px 0px;
}
"

kill_video_wallpapers() {
  pkill -f "mpvpaper.*$focused_monitor" 2>/dev/null || pkill mpvpaper 2>/dev/null
}

mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
  -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o \
  -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.mov" -o -iname "*.webm" \) -print0)

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"

  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    if [[ "$pic_name" =~ \.gif$ ]]; then
      cache_gif_image="$HOME/.cache/gif_preview/${pic_name}.png"
      if [[ ! -f "$cache_gif_image" ]]; then
        mkdir -p "$HOME/.cache/gif_preview"
        magick "$pic_path[0]" -resize 1920x1080 "$cache_gif_image" 2>/dev/null
      fi
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$cache_gif_image"
    elif [[ "$pic_name" =~ \.(mp4|mkv|mov|webm|MP4|MKV|MOV|WEBM)$ ]]; then
      cache_preview_image="$HOME/.cache/video_preview/${pic_name}.png"
      if [[ ! -f "$cache_preview_image" ]]; then
        mkdir -p "$HOME/.cache/video_preview"
        ffmpeg -v error -y -i "$pic_path" -ss 00:00:01.000 -vframes 1 "$cache_preview_image" 2>/dev/null
      fi
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$cache_preview_image"
    else
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$pic_path"
    fi
  done
}

apply_image_wallpaper() {
  local image_path="$1"
  local link_target="$image_path"

  kill_video_wallpapers

  if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon --format xrgb &
    sleep 0.5
  fi

  swww img -o "$focused_monitor" "$image_path" $SWWW_PARAMS

  if [[ "$image_path" =~ \.gif$ ]]; then
    local pic_name=$(basename "$image_path")
    link_target="$HOME/.cache/gif_preview/${pic_name}.png"
  fi

  ln -snf "$link_target" "$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"
  ln -snf "$link_target" "$HOME/.config/rofi/current_wallpaper.png"

  if [[ -f "$SCRIPTSDIR/WallustSwww.sh" ]]; then
    "$SCRIPTSDIR/WallustSwww.sh" "$link_target"
  fi

  sleep 1
  if [[ -f "$SCRIPTSDIR/Refresh.sh" ]]; then
    "$SCRIPTSDIR/Refresh.sh"
  fi
}

apply_video_wallpaper() {
  local video_path="$1"

  if ! command -v mpvpaper &>/dev/null; then
    notify-send -i "$iDIR/error.png" "Error" "mpvpaper is not installed"
    return 1
  fi

  kill_video_wallpapers
  mpvpaper "$focused_monitor" -o "load-scripts=no --no-audio --loop" "$video_path" &

  mkdir -p "$HOME/.cache/video_preview"
  local frame_cache="$HOME/.cache/video_preview/frame_${focused_monitor}.png"
  ffmpeg -v error -y -i "$video_path" -ss 00:00:01.000 -vframes 1 "$frame_cache" 2>/dev/null

  if [[ -f "$frame_cache" ]]; then
    ln -snf "$frame_cache" "$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"
    ln -snf "$frame_cache" "$HOME/.config/rofi/current_wallpaper.png"

    if [[ -f "$SCRIPTSDIR/WallustSwww.sh" ]]; then
      "$SCRIPTSDIR/WallustSwww.sh" "$frame_cache"
    fi
  fi

  sleep 1
  if [[ -f "$SCRIPTSDIR/Refresh.sh" ]]; then
    "$SCRIPTSDIR/Refresh.sh"
  fi
}

main() {
  choice=$(menu | rofi -i -show -dmenu -config "$rofi_theme" -theme-str "$rofi_override")
  choice=$(echo "$choice" | xargs)
  RANDOM_PIC_NAME=$(echo "$RANDOM_PIC_NAME" | xargs)

  if [[ -z "$choice" ]]; then
    exit 0
  fi

  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    choice=$(basename "$RANDOM_PIC")
  fi

  choice_basename=$(basename "$choice" | sed 's/\(.*\)\.[^.]*$/\1/')
  selected_file=$(find "$wallDIR" -iname "$choice_basename.*" -print -quit)

  if [[ -z "$selected_file" ]]; then
    notify-send -i "$iDIR/error.png" "Error" "Selected file not found."
    exit 1
  fi

  if [[ "$selected_file" =~ \.(mp4|mkv|mov|webm|MP4|MKV|MOV|WEBM)$ ]]; then
    apply_video_wallpaper "$selected_file"
  else
    apply_image_wallpaper "$selected_file"
  fi
}

if pidof rofi >/dev/null; then
  pkill rofi
fi

main
