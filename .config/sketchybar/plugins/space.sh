#!/bin/sh

WORKSPACE="${NAME#space_}"

if [ "$SENDER" = "aerospace-workspace-change" ]; then
  FOCUSED="$AEROSPACE_FOCUSED_WORKSPACE"
else
  FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null || echo '1')"
fi

if [ "$FOCUSED" = "$WORKSPACE" ]; then
  # Active: full opacity, border, background
  sketchybar --set "$NAME" \
    icon.color=0xffffffff \
    background.drawing=on \
    background.color=0x20ffffff \
    background.border_color=0xff7aa2f7 \
    background.border_width=2
else
  # Inactive: dimmed, no background
  sketchybar --set "$NAME" \
    icon.color=0xccffffff \
    background.drawing=off \
    background.border_width=0
fi
