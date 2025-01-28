#!/bin/bash

CONFIG_TYPE="$1"
WHAT_CONFIG="$2"
PREFIX_CONFIG_DIR="$(dirname "$(realpath "$0")")"
CONFIG_DIR_HOME=$([ -n "$XDG_CONFIG_HOME" ] && echo -n "$XDG_CONFIG_HOME" || echo -n "$HOME/.config")
DOT_DIR_HOME="$HOME"

help_message() {
  cat <<EOM
usage: $0 [config|dot <config name>] [all]

example: $0 config nvim
EOM
  exit 1
}

if [ $# -le 1 ] && [ "$CONFIG_TYPE" != "all" ]; then
  help_message
fi

link_config() {
  local config_dir="$PREFIX_CONFIG_DIR/config/$1"
  local config_dir_dest="$CONFIG_DIR_HOME/$1"

  if [ ! -d "$config_dir" ]; then
    echo "Error: config '$1' not available"
    exit 1
  fi

  [ -d "$config_dir_dest" ] || [ -L "$config_dir_dest" ] && rm -rf "$config_dir_dest"

  echo -e "Linking: $config_dir \033[0;33mto\033[0m $config_dir_dest"
  ln -sf "$config_dir" "$config_dir_dest"
}

link_dot() {
  local dot_file="$PREFIX_CONFIG_DIR/dot/$1"
  local dot_config_dest="$DOT_DIR_HOME/.$1"

  if [ ! -f "$dot_file" ]; then
    echo "Error: dot config file '$1' not available"
    exit 1
  fi

  [ -f "$dot_config_dest" ] || [ -L "$dot_config_dest" ] && rm -rf "$dot_config_dest"

  echo -e "Linking: $dot_file \033[0;33mto\033[0m $dot_config_dest"
  ln -sf "$dot_file" "$dot_config_dest"
}

link_all() {
  # config
  for c in $PREFIX_CONFIG_DIR/config/*; do
    link_config "${c##*/}"
  done

  # dot file
  for c in $PREFIX_CONFIG_DIR/dot/*; do
    link_dot "${c##*/}"
  done
}

case "$CONFIG_TYPE" in
"config") link_config "$WHAT_CONFIG" ;;
"dot") link_dot "$WHAT_CONFIG" ;;
"all") link_all ;;
*)
  echo -e "Unknown config type '$CONFIG_TYPE'\n"
  help_message
  ;;
esac
