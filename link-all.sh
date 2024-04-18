#!/bin/bash

SCRIPT_PATH="$(realpath `dirname $0`)"
DOT_CONFIG="$HOME/.config"

CONFIG_FILE_DIR=$SCRIPT_PATH/config
ln -sf $CONFIG_FILE_DIR/* $DOT_CONFIG/

NVIM_LUA_DIR="$DOT_CONFIG/nvim/lua"
NVCHAD_CUSTOM_DIR="$SCRIPT_PATH/nvchad/lua/custom"
if [ ! -d "$NVIM_LUA_DIR/core" ]; then
  echo "nvim or nvchad not installed"
else
  ln -sf "$NVCHAD_CUSTOM_DIR" "$NVIM_LUA_DIR/"
fi

DOTFILE_HOME_DIR=$SCRIPT_PATH/dotfile-home
for f in $DOTFILE_HOME_DIR/*; do
  DOT=$HOME/.$(basename $f)
  [ -L "$DOT" ] && rm "$DOT"
  ln -sf "$f" "$DOT"
done
