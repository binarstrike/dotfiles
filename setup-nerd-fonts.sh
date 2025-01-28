#!/usr/bin/bash

set -e

FONT_INSTALL_DIR="$HOME/.fonts/me"
REPO_URL="https://github.com/ryanoasis/nerd-fonts"
TEMP_DIR="/tmp"
LATEST_TAG_NAME="$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq .tag_name -r)"
FONTS_NAME=(ComicShannsMono JetBrainsMono)

[ ! -d "$FONT_INSTALL_DIR" ] && mkdir -p "$FONT_INSTALL_DIR"

echo -e "\033[0;33mDownloading fonts file\033[0m"
for f in "${FONTS_NAME[@]}"; do
  wget -q --show-progress "$REPO_URL/releases/download/$LATEST_TAG_NAME/$f.tar.xz" -O "$TEMP_DIR/$f.tar.xz"
done

echo -e "\033[0;33mExtracting fonts file\033[0m"
for f in "${FONTS_NAME[@]}"; do
  tar -xvf "$TEMP_DIR/$f.tar.xz" -C "$FONT_INSTALL_DIR"
done

echo -e "\033[0;33mReloading fonts cache\033[0m"
fc-cache -vf
