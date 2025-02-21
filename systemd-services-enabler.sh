#!/usr/bin/bash

USER_SERVICES=(
  # hyprland services
  hyprpaper hypridle hyprpolkitagent
  # audio services
  pipewire pipewire-pulse wireplumber
)

SYSTEM_SERVICES=(
  # display manager
  ly
  # bluetooth
  bluetooth
  # network manager
  NetworkManager
)

for s in "${USER_SERVICES[@]}"; do
  printf "start and enable \033[0;33m%s\033[0m service (user)\n" "$s"
  systemctl --user enable --now "$s.service"
done

for s in "${SYSTEM_SERVICES[@]}"; do
  printf "start and enable \033[0;33m%s\033[0m service (system)\n" "$s"
  sudo systemctl enable --now "$s.service"
done
