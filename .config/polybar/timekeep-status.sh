#!/usr/bin/env bash
# Polybar module: show timekeep tracking status from latest weekly note

WEEKLY_DIR="$HOME/Org/Notes/weekly"

# Read colors from active theme
green=$(grep '^aqua1' ~/.config/polybar/colors.ini 2>/dev/null | cut -d= -f2 | tr -d ' ')
red=$(grep '^red1' ~/.config/polybar/colors.ini 2>/dev/null | cut -d= -f2 | tr -d ' ')
: "${green:=#689d6a}"
: "${red:=#cc241d}"

# Find latest weekly note
latest=$(ls "$WEEKLY_DIR"/*.md 2>/dev/null | sort | tail -1)
[[ -z "$latest" ]] && exit 0

# Extract timekeep JSON block
json=$(sed -n '/^```timekeep$/,/^```$/{/^```/d;p}' "$latest" | tr -d '\n')
[[ -z "$json" ]] && exit 0

# Check if ANY entry (or sub-entry) is currently running
running=$(echo "$json" | jq -r '
  [.entries[] |
    if .subEntries != null and (.subEntries | length) > 0
    then .subEntries[]
    else . end
  ] | map(select(.startTime != null and .endTime == null)) | length > 0
')

ICON_PLAY=$(printf '\xef\x81\x8b')   # U+F04B
ICON_PAUSE=$(printf '\xef\x81\x8c')  # U+F04C

if [[ "$running" == "true" ]]; then
  echo "%{F${green}}${ICON_PLAY}%{F-}"
else
  echo "%{F${red}}${ICON_PAUSE}%{F-}"
fi
