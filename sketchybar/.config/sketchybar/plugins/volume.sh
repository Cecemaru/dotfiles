#!/usr/bin/env bash
VOL=$(osascript -e "output volume of (get volume settings)" 2>/dev/null)
MUTED=$(osascript -e "output muted of (get volume settings)" 2>/dev/null)
if [ "$MUTED" = "true" ] || [ "$VOL" = "0" ]; then ICON=""
elif [ "$VOL" -ge 60 ]; then ICON=""
elif [ "$VOL" -ge 30 ]; then ICON=""
else ICON=""; fi
sketchybar --set "$NAME" icon="$ICON" label="${VOL}%"
