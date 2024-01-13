#!/usr/bin/env bash
get_ip() {
    ip_sites=(
        "https://ipinfo.io/ip"
        "https://ifconfig.me"
        "http://ip.42.pl/raw"
        "https://icanhazip.com"
        "https://ipecho.net/plain"
        "https://v4.ident.me"
    )
    local num_sites=${#ip_sites[@]}
    local random_index=$((RANDOM % num_sites))
    local random_site=${ip_sites[random_index]}
    local ip=$(curl --connect-timeout 3 -s $random_site)
    if [ ! -n "$ip" ]; then
        notify-send "Cannot get IP" "There are some problems with $random_site"
    else
        notify-send "Current IP" "$ip"
    fi
}

print_status() {
    connection=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1 | awk -F'/' '{print $NF}')
    if [ -n "$connection" ]; then
        echo "%{u83a598}%{+u}%{F#83a598} ${connection}%{F-}%{u-}"
    else
        # echo "%{u585858}%{+u}%{F#585858}%{F-}%{u-}"
        echo ""
    fi
}

case $1 in
  tail)
    trap print_status USR1

    while true
     do
     print_status
     sleep ${2} &
     wait
    done
    ;;
  get_ip)
    get_ip
    kill -USR1 $(pgrep --oldest --parent ${2})
    ;;
  *)
    echo "Invalid option: ${1}."
    ;;
esac
