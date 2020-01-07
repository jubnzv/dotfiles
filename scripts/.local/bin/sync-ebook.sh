#!/usr/bin/env bash
device=`sudo /sbin/blkid | ag LABEL=\"PB740\" | awk -F':' '{ print $1 }'`
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

echo "Syncing $HOME/Documents/ with $mount_point ..."
rsync -aurq -L --progress \
    --exclude '*tar.gz'   \
    --exclude '*tar.xz'   \
    --exclude '*tar.bz2'  \
    --exclude '*.rar'     \
    --exclude 'websites'  \
    --exclude '*.html'    \
    --exclude '*.7z'      \
    --exclude '*.zip'     \
    $HOME/Documents/ "$mount_point"/Documents
