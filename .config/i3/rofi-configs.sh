#!/usr/bin/env bash
EDITOR="kitty -e nvim"

# Default settings
_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

configs=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.config/nvim/lua/init.lua"
    "$HOME/.tmux.conf"
    "$HOME/.gdbinit"
    "$HOME/.ssh/config"
    "$HOME/.ideavimrc"
    "$HOME/.config/i3/config"
    "$HOME/.config/polybar/config"
    "$HOME/.config/ranger/rc.conf"
)

select=$(echo ${configs[@]} | tr ' ' '\n'  | _rofi -dmenu -mesg "Config" -p "> ")
if [ ! $select ]; then
    exit
fi
$EDITOR $select
