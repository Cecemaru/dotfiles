#!/usr/bin/env bash
PWR=$(blueutil -p 2>/dev/null)
if [ "$PWR" = "1" ]; then
    CONNECTED=$(blueutil --connected 2>/dev/null | wc -l | tr -d ' ')
    if [ "$CONNECTED" -gt 0 ]; then
        sketchybar --set "$NAME" icon="󰂱" label="$CONNECTED" label.drawing=on
    else
        sketchybar --set "$NAME" icon="󰂯" label.drawing=off
    fi
else
    sketchybar --set "$NAME" icon="󰂲" label.drawing=off
fi
