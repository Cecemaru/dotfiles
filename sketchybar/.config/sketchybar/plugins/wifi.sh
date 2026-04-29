#!/usr/bin/env bash
IP=$(ipconfig getifaddr en0 2>/dev/null)
if [ -n "$IP" ]; then
    sketchybar --set "$NAME" icon="󰖩" label.drawing=off
else
    sketchybar --set "$NAME" icon="󰖪" label="off" label.drawing=on
fi
