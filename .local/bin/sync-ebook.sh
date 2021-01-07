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

echo "[$(date +'%H:%M:%S')] Syncing $HOME/Documents/ with $mount_point ..."
rsync --update -aurP -L   \
    --delete              \
    --exclude '*tar.gz'   \
    --exclude '*tar.xz'   \
    --exclude 'cv'        \
    --exclude '*tar.bz2'  \
    --exclude '*.rar'     \
    --exclude 'websites'  \
    --exclude '_Archive'  \
    --exclude '*.html'    \
    --exclude '*.7z'      \
    $HOME/Documents/ "$mount_point"/Documents
echo "[$(date +'%H:%M:%S')] Done"
