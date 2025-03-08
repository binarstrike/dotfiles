#!/usr/bin/bash

ICON_THEMES=(
  "Bibata-Modern-Amber"
  "Bibata-Modern-Ice"
)

DOWNLOAD_URL=(
  "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/latest/download/hypr_Bibata-Modern-Amber.tar.gz"
  "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/latest/download/hypr_Bibata-Modern-Ice.tar.gz"
)

ICON_INSTALL_DIR="$HOME/.local/share/icons"

[ ! -d "$ICON_INSTALL_DIR" ] && mkdir "$ICON_INSTALL_DIR"

for i in "${!ICON_THEMES[@]}"; do
  printf "\033[0;33mDownloading %s cursor theme...\n\033[0m" "${ICON_THEMES[$i]}"
  curl -L "${DOWNLOAD_URL[$i]}" -o "/tmp/${ICON_THEMES[$i]}.tar.gz"

  printf "\033[0;33mExtracting %s cursor theme...\n\033[0m" "${ICON_THEMES[$i]}"
  icon_dir="$ICON_INSTALL_DIR/${ICON_THEMES[$i]}"
  [ ! -d "$icon_dir" ] && mkdir -p "$icon_dir"
  tar -xzf "/tmp/${ICON_THEMES[$i]}.tar.gz" -C "$icon_dir"

  printf "\033[0;33mCleaning up...\n\033[0m"
  rm "/tmp/${ICON_THEMES[$i]}.tar.gz"
done
