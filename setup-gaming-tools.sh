#!/usr/bin/bash

set -e

PACMAN_PKGS=(
  wine lutris
  # graphics drivers
  vulkan-headers vulkan-icd-loader vulkan-intel vulkan-tools libva-intel-driver intel-gmmlib intel-media-drive vkd3d mesa
  # 32-bit drivers and libraries
  lib32-gnutls lib32-mesa lib32-vkd3d lib32-vulkan-icd-loader lib32-vulkan-intel lib32-vulkan-mesa-layer lib32-vkd3d
  # other tools
  mangohud lib32-mangohud gamemode lib32-gamemode
)

echo "Installing packages..."

sudo pacman -Sy

for pkg in "${PACMAN_PKGS[@]}"; do
  sudo pacman -S --noconfirm "$pkg"
done
