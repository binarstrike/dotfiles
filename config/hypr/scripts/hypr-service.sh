#!/bin/sh

for s in hypridle hyprpaper; do
    systemctl --user start "$s.service"
done
