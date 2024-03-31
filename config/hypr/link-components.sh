#!/usr/bin/bash

HYPR_COMPONENTS=$HOME/.config/hypr/components

for c in $HYPR_COMPONENTS/*; do
  ln -sf $c $HOME/.config/
done
