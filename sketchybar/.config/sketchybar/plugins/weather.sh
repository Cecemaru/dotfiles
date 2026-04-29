#!/usr/bin/env bash
CACHE=/tmp/sketchybar_weather
MAX_AGE=1800
if [ -f "$CACHE" ]; then
    AGE=$(( $(date +%s) - $(stat -f %m "$CACHE") ))
    if [ "$AGE" -lt "$MAX_AGE" ]; then
        sketchybar --set "$NAME" label="$(cat $CACHE)"
        exit 0
    fi
fi
# tr -s ' ' = çoklu boşluğu teke indir; xargs = trim
WEATHER=$(curl -sf --max-time 5 "wttr.in/?format=%c%t" 2>/dev/null | tr -d '+' | tr -s ' ' | xargs)
if [ -n "$WEATHER" ]; then
    echo "$WEATHER" > "$CACHE"
    sketchybar --set "$NAME" label="$WEATHER"
fi
