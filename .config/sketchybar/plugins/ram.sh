#!/bin/sh

PAGE_SIZE=$(sysctl -n hw.pagesize)
TOTAL_BYTES=$(sysctl -n hw.memsize)

VM=$(vm_stat)
PAGES_FREE=$(echo "$VM" | awk '/Pages free/        {gsub(/\./, "", $3); print $3+0}')
PAGES_SPEC=$(echo "$VM" | awk '/Pages speculative/ {gsub(/\./, "", $3); print $3+0}')
PAGES_FILE=$(echo "$VM" | awk '/File-backed pages/ {gsub(/\./, "", $3); print $3+0}')

USED_BYTES=$(( TOTAL_BYTES - (PAGES_FREE + PAGES_SPEC + PAGES_FILE) * PAGE_SIZE ))
USED_GB=$(echo "scale=1; $USED_BYTES / 1073741824" | bc)
TOTAL_GB=$(echo "scale=0; $TOTAL_BYTES / 1073741824" | bc)

sketchybar --set "$NAME" icon="󰍛" label="${USED_GB}/${TOTAL_GB}G"
