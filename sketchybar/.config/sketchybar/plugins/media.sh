#!/usr/bin/env bash
TITLE=$(nowplaying-cli get title 2>/dev/null)
ARTIST=$(nowplaying-cli get artist 2>/dev/null)
STATE=$(nowplaying-cli get playbackRate 2>/dev/null)
if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi
if [ "$STATE" = "1" ]; then ICON=""
else ICON=""; fi
LABEL="$TITLE"
[ -n "$ARTIST" ] && [ "$ARTIST" != "null" ] && LABEL="$ARTIST - $TITLE"
LABEL="${LABEL:0:35}"
sketchybar --set "$NAME" drawing=on icon="$ICON" label="$LABEL"
