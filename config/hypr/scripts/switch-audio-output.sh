#!/usr/bin/bash

default_sink=$(pactl get-default-sink)

for sink in $(pactl list sinks short | awk '{print $2}'); do
  if [[ $sink == "$default_sink" ]]; then
    continue
  fi

  pactl set-default-sink "$sink"
  exit 0
done
