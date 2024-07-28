#!/bin/sh

for s in hyprpaper hypridle dunst; do
    systemctl --user start "$s.service"
done
