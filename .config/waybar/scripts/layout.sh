#!/usr/bin/env bash
layout="$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "65261:4871:ZSA_Ergodox_EZ") | .xkb_active_layout_name')"
if [[ "$layout" == "Russian" ]]; then
    echo '🇷🇺'
else
    echo '🇺🇸'
fi
