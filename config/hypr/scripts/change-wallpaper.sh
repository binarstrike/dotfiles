#!/usr/bin/bash

set -e

CONFIG_DIR_HOME=$([ -n "$XDG_CONFIG_HOME" ] && echo -n "$XDG_CONFIG_HOME" || echo -n "$HOME/.config")
WP_DIR="$CONFIG_DIR_HOME/hypr/wallpapers"
WP_COUNT=$(find "$WP_DIR" -type f ! -name ".*" | wc -l)

ACTIVE_WP_PATH=$(hyprctl hyprpaper listactive | awk '{print $3}')
NUM_ACTIVE_WP=${ACTIVE_WP_PATH##*/}
NUM_ACTIVE_WP=${NUM_ACTIVE_WP%.*}

if [ ! $((NUM_ACTIVE_WP++)) -ge "$WP_COUNT" ]; then
  NEXT_WP_NUM=$((NUM_ACTIVE_WP++))
else
  NEXT_WP_NUM=1
fi

hyprctl hyprpaper unload "$ACTIVE_WP_PATH"
hyprctl hyprpaper preload "$WP_DIR/$NEXT_WP_NUM.jpg"
hyprctl hyprpaper wallpaper eDP-1,"$WP_DIR/$NEXT_WP_NUM.jpg"
