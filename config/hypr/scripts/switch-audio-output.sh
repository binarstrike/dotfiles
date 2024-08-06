#!/bin/sh

# Just a simple script to toggle the default audio output between two devices.
# TODO: make the script accept more than two audio output devices.

default_sink=`pactl get-default-sink`

for sink in `pactl list sinks short | awk '{print $2}'`; do
    if [[ $sink == $default_sink ]]; then
        continue
    fi

    pactl set-default-sink $sink
    exit 0
done
