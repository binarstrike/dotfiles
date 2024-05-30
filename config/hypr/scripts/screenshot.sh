#!/usr/bin/bash

set -e

[ $# -eq 0 ] && exit 1

ARGS=$(getopt --options c,f,o: --longoptions copy,full,output: -- "$@")

eval set -- "$ARGS"

while :; do
  case "$1" in
    -c | --copy) COPY_SS=true; shift ;;
    -f | --full) FULL=true; shift ;;
    -o | --output) OUT_FILE="$2"; shift 2 ;;
    --) shift; break ;;
    *) echo "Unknown option $1"; exit 1 ;;
  esac
done

if [ -z $OUT_FILE ]; then
  SS_DIR="$HOME/Pictures/Screenshots"
  [ ! -d $SS_DIR ] && mkdir -p $SS_DIR

  OUT_FILE=$SS_DIR/$(date +"Screenshot_%Y-%m-%d_%H.%M.%S.png")
fi

if [ $FULL ]; then
  grim -t png $OUT_FILE
else
  grim -t png -g "$(slurp)" $OUT_FILE
fi

if [ $COPY_SS ]; then
  wl-copy <$OUT_FILE
  notify-send "Screenshot copied to clipboard" -a "ss" -u low
fi
