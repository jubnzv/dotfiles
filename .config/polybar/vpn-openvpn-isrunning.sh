#!/usr/bin/env bash
connection=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1 | awk -F'/' '{print $NF}')
if [ -n "$connection" ]; then
    echo " ${connection}"
else
    echo ""
fi
