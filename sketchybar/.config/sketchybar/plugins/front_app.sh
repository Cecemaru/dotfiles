#!/usr/bin/env bash
# Aktif uygulama adını yazar
if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set "$NAME" label="$INFO"
fi
