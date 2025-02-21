#!/usr/bin/bash

set -e

PKGS_PACMAN=(
  # display manager, hyprland
  ly hyprland aquamarine hyprpaper hyprlock hypridle hyprpolkitagent hyprland-protocols hyprutils hyprcursor hyprgraphics hyprsunset hyprlang hyprland-qtutils
  # xdg desktop portal (file chooser, screen sharing)
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  # session manager
  uwsm
  # brightness control, audio server and control
  brightnessctl pipewire pipewire-jack pipewire-pulse pipewire-alsa wireplumber pavucontrol playerctl
  # audio filter and effect
  easyeffects ardour calf lsp-plugins-lv2 zam-plugins-lv2 mda.lv2 yelp
  # start menu, notification daemon
  rofi mako
  # terminal stuff
  alacritty tmux fastfetch htop neovim
  # fonts
  noto-fonts noto-fonts-cjk noto-fonts-emoji
  # graphic drivers and utilities
  intel-gmmlib intel-media-driver libva-intel-driver mesa mesa-utils vulkan-headers vulkan-icd-loader vulkan-intel vulkan-tools
  # microcode and firmware
  intel-ucode linux-firmware
  # network tools
  networkmanager iwd dhclient
  # file manager
  nautilus
  # shell
  zsh
  # other apps
  discord
  # compiler, build tools
  nodejs npm go base-devel cmake
  # utility packages
  grim slurp wl-clipboard fzf fd zoxide exa zip 7zip unzip ripgrep wget curl jq wev dnsutils
  # media player, media converter
  mpv ffmpeg imagemagick
  # kernel
  linux-zen
  # other packages
  gvfs-mtp mtpfs sshfs gvfs-smb xfsprogs git
)

PKGS_AUR=(
  # clipboard manager
  clipman
  # utilitiy tools
  jid-bin
  # music player
  spotify
  # web browser
  google-chrome
  # other packages
  wayneko-git
  # prompt customization
  oh-my-posh-bin
)

disable_debug_flag() {
  echo "Disabling debug flag"
  sudo sed -i 's/purge debug/purge !debug/g' /etc/makepkg.conf || true
}

if ! command -v yay >/dev/null 2>&1; then
  echo "Installing yay aur helper"
  sudo pacman -Sy
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  yes | makepkg -si
  cd ..
  rm -rf yay-bin
fi

echo "Installing required packages"
sudo pacman -S --noconfirm "${PKGS_PACMAN[@]}"

echo "Installing required packages (aur)"
disable_debug_flag
yes | yay -S --noconfirm "${PKGS_AUR[@]}"
