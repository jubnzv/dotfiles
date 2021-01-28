#!/usr/bin/env bash
device=`sudo /sbin/blkid | grep LABEL=\"PB740_CARD\" | awk -F':' '{ print $1 }'`
trap 'sudo -k' EXIT
if [[ $device == "" ]]; then
    echo "Device is not mounted! Bailing out."
    exit 127
fi

mount_point=`mount | ag $device | awk -F' ' '{ print $3 }'`
if [ ! -d $mount_point ]; then
    echo "$mount_point is inaccessible"
    exit 127
fi

T="$(date +%s)"
echo "Syncing $HOME/Documents/ with $mount_point ..."
rsync --update -aqurP -L  \
    --delete              \
    --include '*.pdf'     \
    --include '*.djvu'    \
    --include '*.epub'    \
    --include '*.fb2*'    \
    --include '*/'        \
    --exclude '*'         \
    --exclude 'cv'        \
    --exclude 'websites'  \
    --exclude '_Archive'  \
    $HOME/Documents/ "$mount_point"/Documents
T="$(($(date +%s)-T))"
printf "Sync time: %dd %02d:%02d:%02d\n" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))"
