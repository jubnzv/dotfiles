#!/usr/bin/env bash
EDITOR="$TERMINAL -e nvim"
if command -v "nvim-qt" &> /dev/null; then
    EDITOR=nvim-qt
fi

# Default settings
_rofi () {
    rofi -regex -tokenize -i -lines 30 -width 1500 -no-levenshtein-sort "$@"
}

configs=(
    "$HOME/.zshrc"
    "$HOME/.config/nvim/init.vim"
    "$HOME/.tmux.conf"
    "$HOME/.ssh/config"
    "$HOME/.config/i3/config"
    "$HOME/.config/polybar/config.ini"
    "$HOME/.config/kitty/kitty.conf"
)

select=$(echo ${configs[@]} | tr ' ' '\n'  | _rofi -dmenu -mesg "Config" -p "> ")
if [ ! $select ]; then
    exit
fi
$EDITOR $select
