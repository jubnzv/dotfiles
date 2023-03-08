#!/usr/bin/env bash

pidfile="/var/run/user/$UID/polybar-mic-script.pid"

cleanup() {
	rm -f "$pidfile"
}

if [ -e "$pidfile" ]; then
	kill "$(cat "${pidfile}")" > /dev/null 2>&1
	cleanup
fi

print_status() {
	if amixer get Capture | grep -q '\[off\]'; then
		echo %{F#ff6200}""%{F-}
	else
		echo %{F#689d6a}""%{F-}
	fi
}

toggle() {
	amixer set Capture toggle > /dev/null 2>&1
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
  toggle)
    toggle
    kill -USR1 $(pgrep --oldest --parent ${2})
    ;;
  update)
    kill -USR1 $(pgrep --oldest --parent ${2})
    ;;
  *)
    echo "Invalid option: ${1}."
    ;;
esac

