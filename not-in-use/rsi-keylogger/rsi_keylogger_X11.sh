#!/bin/bash
TS=`date +%Y-%m-%d`
LOG_FILE=/home/jubnzv/Org/Data/kbd/${TS}.csv

xinput list | grep -Po 'id=\K\d+(?=.*slave\s*keyboard)' | xargs -P0 -n1 xinput test | stdbuf -o0 awk '{printf "%ld,%s\n", systime(), $3}' >> $LOG_FILE
