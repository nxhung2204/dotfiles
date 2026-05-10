#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
elif [ "$PERCENTAGE" -ge 90 ]; then
  ICON="󰁹"
elif [ "$PERCENTAGE" -ge 60 ]; then
  ICON="󰂀"
elif [ "$PERCENTAGE" -ge 30 ]; then
  ICON="󰁾"
elif [ "$PERCENTAGE" -ge 10 ]; then
  ICON="󰁻"
else
  ICON="󰁺"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
