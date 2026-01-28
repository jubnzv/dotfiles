#!/bin/bash
MOZILLA_CONFIG=~/.mozilla
FIREFOX='/opt/firefox/firefox-bin'
NAMES=($(awk -F "=" '/Name/ {print $2}' $MOZILLA_CONFIG/firefox/profiles.ini | tr -d ' '))
PATHS=($(awk -F "=" '/Path/ {print $2}' $MOZILLA_CONFIG/firefox/profiles.ini | tr -d ' '))

PROFILE=$(printf '%s\n' "${NAMES[@]}" | rofi -dmenu -p "Firefox Profile")

[ -z "$PROFILE" ] && exit

for i in "${!NAMES[@]}"; do
    if [[ "${NAMES[$i]}" = "${PROFILE}" ]]; then
        $FIREFOX --new-instance --profile "$MOZILLA_CONFIG/firefox/${PATHS[$i]}" >/dev/null &
        exit
    fi
done

$FIREFOX --new-instance --ProfileManager >/dev/null &
