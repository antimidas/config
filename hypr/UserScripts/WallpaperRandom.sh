#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Random Wallpaper ( CTRL ALT W)
# Picks a random file (image OR video) and applies it to the focused monitor

PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
wallDIR="$PICTURES_DIR/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

if [[ -z "$focused_monitor" ]]; then
  notify-send "Error" "Could not detect focused monitor"
  exit 1
fi

# Transition config (images only)
FPS=30
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Gather every image and video file (null-delimited, so spaces in filenames are safe)
mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
  -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.pnm" -o \
  -iname "*.tga" -o -iname "*.farbfeld" -o \
  -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.mov" -o -iname "*.webm" \) -print0)

if [[ ${#PICS[@]} -eq 0 ]]; then
  notify-send "Error" "No wallpapers found in $wallDIR"
  exit 1
fi

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"

kill_video_wallpapers() {
  # Only target the mpvpaper instance running on THIS monitor, and make sure
  # it's actually gone (layer surface unmapped) before we return - otherwise
  # swww's image can be applied underneath a still-alive video layer and
  # never actually show up.
  local pattern="mpvpaper ${focused_monitor} "
  local pids
  pids=$(pgrep -f "$pattern")

  if [[ -z "$pids" ]]; then
    return 0
  fi

  kill $pids 2>/dev/null

  for _ in $(seq 1 20); do
    pgrep -f "$pattern" >/dev/null || return 0
    sleep 0.1
  done

  # Still alive after ~2s - force kill
  pkill -9 -f "$pattern" 2>/dev/null
}

apply_image_wallpaper() {
  local image_path="$1"
  local link_target="$image_path"

  kill_video_wallpapers

  swww query >/dev/null 2>&1 || swww-daemon --format xrgb &
  sleep 0.5

  swww img -o "$focused_monitor" "$image_path" $SWWW_PARAMS

  if [[ "$image_path" =~ \.gif$ ]]; then
    local pic_name
    pic_name=$(basename "$image_path")
    link_target="$HOME/.cache/gif_preview/${pic_name}.png"
    if [[ ! -f "$link_target" ]]; then
      mkdir -p "$HOME/.cache/gif_preview"
      magick "$image_path[0]" -resize 1920x1080 "$link_target" 2>/dev/null
    fi
  fi

  ln -snf "$link_target" "$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"

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
    notify-send "Error" "mpvpaper is not installed"
    return 1
  fi

  kill_video_wallpapers
  mpvpaper "$focused_monitor" -o "load-scripts=no --no-audio --loop --panscan=1.0" "$video_path" &

  mkdir -p "$HOME/.cache/video_preview"
  local frame_cache="$HOME/.cache/video_preview/frame_${focused_monitor}.png"
  ffmpeg -v error -y -i "$video_path" -ss 00:00:01.000 -vframes 1 "$frame_cache" 2>/dev/null

  if [[ -f "$frame_cache" ]]; then
    ln -snf "$frame_cache" "$HOME/.config/rofi/current_desktop_image_${focused_monitor}.png"

    if [[ -f "$SCRIPTSDIR/WallustSwww.sh" ]]; then
      "$SCRIPTSDIR/WallustSwww.sh" "$frame_cache"
    fi
  fi

  sleep 1
  if [[ -f "$SCRIPTSDIR/Refresh.sh" ]]; then
    "$SCRIPTSDIR/Refresh.sh"
  fi
}

if [[ "$RANDOM_PIC" =~ \.(mp4|mkv|mov|webm|MP4|MKV|MOV|WEBM)$ ]]; then
  apply_video_wallpaper "$RANDOM_PIC"
else
  apply_image_wallpaper "$RANDOM_PIC"
fi
