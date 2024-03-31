#!/bin/bash

for x in xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal; do
  killall $x
done

/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
