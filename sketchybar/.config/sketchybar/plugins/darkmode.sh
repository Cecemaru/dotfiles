#!/usr/bin/env bash
MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
if [ "$MODE" = "Dark" ]; then
    sketchybar --set "$NAME" icon="" label.drawing=off
else
    sketchybar --set "$NAME" icon="" label.drawing=off
fi
