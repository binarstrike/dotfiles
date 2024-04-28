#!/bin/bash

SCRIPT_PATH="$(realpath `dirname $0`)"
DOT_CONFIG="$HOME/.config"

CONFIG_FILE_DIR=$SCRIPT_PATH/config
ln -sf $CONFIG_FILE_DIR/* $DOT_CONFIG/

DOTFILE_HOME_DIR=$SCRIPT_PATH/dotfile-home
for f in $DOTFILE_HOME_DIR/*; do
  DOT=$HOME/.$(basename $f)
  [ -L "$DOT" ] && rm "$DOT"
  ln -sf "$f" "$DOT"
done
