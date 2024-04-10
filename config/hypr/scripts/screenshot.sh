#!/usr/bin/bash

set -e

for c in grim slurp; do
  if ! command -v $c >/dev/null; then
    notify-send "$c must be installed" -u critical -a "ERROR"
    exit 1
  fi
done

SS_DIR="$HOME/Pictures/Screenshots"
[ ! -d $SS_DIR ] && mkdir -p $SS_DIR

OUTPUT_FILENAME_PATH=$SS_DIR/$(date +"Screenshot_%Y-%m-%d_%H.%M.%S.png")

if [ "$1" == "--full" ]; then
  grim -t png - >$OUTPUT_FILENAME_PATH
else
  grim -t png -g "$(slurp)" - >$OUTPUT_FILENAME_PATH
fi

wl-copy <$OUTPUT_FILENAME_PATH
notify-send "Screenshot copied to clipboard" -a "ss" -u low
