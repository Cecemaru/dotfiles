#!/usr/bin/env bash
# Aerospace workspace highlight — focused workspace'i renklendirir.
# $1 = workspace numarası (sketchybarrc'den geçer)
# FOCUSED_WORKSPACE env yoksa aerospace'e direkt sor (init zamanı için)

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

if [ "$1" = "$FOCUSED" ]; then
    sketchybar --set "$NAME" background.drawing=on \
                            background.color=0xffcba6f7 \
                            icon.color=0xff1e1e2e
else
    sketchybar --set "$NAME" background.drawing=off \
                            icon.color=0xffcdd6f4
fi
