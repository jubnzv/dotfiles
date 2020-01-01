#!/usr/bin/env bash
yes | pv | ssh $1 "cat >/dev/null"
