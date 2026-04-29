#!/usr/bin/env bash
CPU=$(top -l 1 | grep -E "^CPU" | awk '{print $3+$5}')
sketchybar --set "$NAME" label="${CPU}%"
