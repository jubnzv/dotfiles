#!/usr/bin/env bash
if [[ $(date +%u) -lt 6 ]] ; then
    exec mattermost-desktop
fi
