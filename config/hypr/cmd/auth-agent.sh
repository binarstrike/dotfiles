#!/bin/bash

for c in /usr/lib/polkit-kde-authentication-agent-1 /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1; do
  if [ -x "$c" ]; then
    "$c" 2>&1 >/dev/null &
    exit 0
  else
    continue
  fi
done
notify-send "Please install one of authentication agent kde or gnome" -a "ERROR" -u critical
