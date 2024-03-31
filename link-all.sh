#!/bin/bash

SC_PATH=$(realpath `dirname $0`)
DOT_CONFIG=$HOME/.config

CONFIG_FILE_DIR=$SC_PATH/config
ln -sf $CONFIG_FILE_DIR/* $HOME/.config/

NVIM_LUA_DIR=$DOT_CONFIG/nvim/lua
NVCHAD_CUSTOM_DIR=$SC_PATH/nvchad-custom
if [ ! -d $NVIM_LUA_DIR ]; then
  echo "nvim or nvchad not installed"
else
  CUSTOM_DIR=$NVIM_LUA_DIR/custom

  [ -L $CUSTOM_DIR ] && rm $CUSTOM_DIR

  ln -sf $NVCHAD_CUSTOM_DIR $CUSTOM_DIR
fi

DOTFILE_HOME_DIR=$SC_PATH/dotfile-home
for f in $DOTFILE_HOME_DIR/*; do
  ln -sf $f "$HOME/.$(basename $f)"
done
