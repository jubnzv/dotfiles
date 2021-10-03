#!/usr/bin/env bash
#
# A script that runs rofi to view and create notes in ~/Org/Notes/ directory.
# Note files are presented in the markdown (.md) format.
#
EDITOR="$TERMINAL -e nvim"
if command -v "nvim-qt" &> /dev/null; then
    EDITOR=nvim-qt
fi
NOTES_DIR=~/Org/Notes/

_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

if [ -n "$@" ]; then
    NOTES_DIR="${NOTES_DIR}/$@"
fi

if [ ! -d "${NOTES_DIR}" ]; then
    if [ -x "${NOTES_DIR}" ]
    then
        coproc ( "${NOTES_DIR}" &  > /dev/null 2>&1 )
        exec 1>&-
        exit;
    elif [ -f "${NOTES_DIR}" ]
    then
        coproc ( ${EDITOR} "${NOTES_DIR}" & > /dev/null  2>&1 )
        exit;
    fi
    exit;
fi

if [ -n "${NOTES_DIR}" ]; then
    NOTES_DIR=$(readlink -e "${NOTES_DIR}")
    pushd "${NOTES_DIR}" >/dev/null
fi

select=$(ls --group-directories-first --color=never --indicator-style=slash -tu | egrep -v '(img|tags|site_html|templates)' | _rofi -dmenu -mesg "Note" -p "> ")
if [ ! $select ]; then
    exit
fi

note=$NOTES_DIR/$select
if [ ! -f $note ] && [[ ! $note =~ .*.md$ ]]; then
    note="$NOTES_DIR/${select///}".md
fi
$EDITOR "$note"

