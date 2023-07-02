#!/usr/bin/env bash
#
# A script that runs rofi to view and create text notes in the given directory.
# Its main purpose is quick access to notes in markdown and org format.
#
# Usage examples:
#  ./rofi-notes.sh ~/Org/Notes '.md'        # access .md files in ~/Org/Notes
#  ./rofi-notes.sh ~/Org/org-mode '.org'    # access .org files in ~/Org/org-mode
#
export GPG_TTY='tty'
# EDITOR="kitty -e nvim"
EDITOR="nvim-qt"
NOTES_DIR=~/Org/Notes/; [ ! -z "$1" ] && NOTES_DIR=$1
EXT='.md'; [ ! -z "$2" ] && EXT=$2

_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

if [ -n "${NOTES_DIR}" ]; then
    NOTES_DIR=$(readlink -e "${NOTES_DIR}")
    pushd "${NOTES_DIR}" >/dev/null
fi

select=$(ls --group-directories-first --color=never --indicator-style=slash -tu | egrep -v '(img|tags|site_html|templates|/$|\.:)' | _rofi -dmenu -mesg "Note" -p "> ")
if [ ! $select ]; then
    exit
fi

note=$NOTES_DIR/$select
if [ ! -f $note ] && [[ ! $note =~ .*."${EXT}"$ ]] && [[ ! $note =~ .*."${EXT}.asc"$ ]]; then
    note="$NOTES_DIR/${select///}.${EXT}"
fi
$EDITOR "$note"
