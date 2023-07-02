#!/usr/bin/env bash
export GPG_TTY='tty'
TERMINAL="kitty"
VPN_DIR=~/VPN/; [ ! -z "$1" ] && VPN_DIR=$1
EXT='.ovpn'

openvpn_pid=$(pgrep -x "openvpn")
if [[ -n "$openvpn_pid" ]]; then
    notify-send "OpenVPN is already running" "PID $openvpn_pid"
    exit 1
fi

_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

if [ -n "${VPN_DIR}" ]; then
    VPN_DIR=$(readlink -e "${VPN_DIR}")
    pushd "${VPN_DIR}" >/dev/null
fi

select=$(ls --group-directories-first --color=never --indicator-style=slash -tu | egrep ".*${EXT}$" | _rofi -dmenu -mesg "OpenVPN config" -p "> ")
if [ ! $select ]; then
    exit
fi

vpn_confg=$VPN_DIR/$select
if [ ! -f $vpn_confg ] && [[ ! $vpn_confg =~ .*."${EXT}"$ ]]; then
    vpn_confg="$VPN_DIR/${select///}.${EXT}"
fi
# TODO:
# $TERMINAL -e --title "__openvpn" sudo /bin/bash -c "openvpn $vpn_confg & && i3-msg '[title=\"__openvpn\"] move container to workspace number 3' || 1 && fg"
$TERMINAL -e --title "__openvpn" sudo /bin/bash -c "openvpn $vpn_confg"
