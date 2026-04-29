#!/usr/bin/env bash
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')
[ -z "$PERCENTAGE" ] && exit 0

case "${PERCENTAGE}" in
    9[0-9]|100) ICON="" ;;   # full
    [6-8][0-9]) ICON="" ;;   # 3/4
    [3-5][0-9]) ICON="" ;;   # half
    [1-2][0-9]) ICON="" ;;   # 1/4
    *)          ICON="" ;;   # empty
esac
[ -n "$CHARGING" ] && ICON=""   # bolt

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
