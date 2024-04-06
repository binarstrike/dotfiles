#!/usr/bin/bash

for c in waybar hyprpaper dunst hypridle; do
  "$c" 2>&1 >/dev/null &
done

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
notify-send "hello $(whoami)" -u low
