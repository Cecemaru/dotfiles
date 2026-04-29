#!/usr/bin/env bash
# Aerospace workspace highlight — focused workspace'i renklendirir.
# $1 = workspace numarası (sketchybarrc'den geçer)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" background.drawing=on \
                            background.color=0xffcba6f7 \
                            icon.color=0xff1e1e2e
else
    sketchybar --set "$NAME" background.drawing=off \
                            icon.color=0xffcdd6f4
fi
