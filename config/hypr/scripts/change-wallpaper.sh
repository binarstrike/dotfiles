#!/bin/sh

WP_DIR=~/.config/hypr/wallpapers
WP_COUNT=`ls -l $WP_DIR | wc -l`

ACTIVE_WP_PATH=`hyprctl hyprpaper listactive | awk '{print $3}'`
NUM_ACTIVE_WP=${ACTIVE_WP_PATH##*/} # base file name
NUM_ACTIVE_WP=${NUM_ACTIVE_WP%.*} # file name without extension

if [ ! $(($NUM_ACTIVE_WP+1)) -ge $WP_COUNT ]; then
    NEXT_WP_NUM=$(($NUM_ACTIVE_WP+1))
else
    NEXT_WP_NUM=1
fi

hyprctl hyprpaper unload $ACTIVE_WP_PATH >/dev/null
hyprctl hyprpaper preload "$WP_DIR/$NEXT_WP_NUM.jpg" >/dev/null
hyprctl hyprpaper wallpaper eDP-1,"$WP_DIR/$NEXT_WP_NUM.jpg"
