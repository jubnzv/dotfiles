#!/bin/bash
# Initialize theme symlinks and set background color on i3 startup

DOTFILES="$HOME/dotfiles/.config"
STATE_FILE="$HOME/.config/theme-mode"
mode=$(cat "$STATE_FILE" 2>/dev/null || echo "dark")

# Ensure symlinks exist in ~/.config pointing to dotfiles
ln -sf "$DOTFILES/i3/colors-$mode.conf" ~/.config/i3/colors.conf
ln -sf "$DOTFILES/polybar/colors-$mode.ini" ~/.config/polybar/colors.ini
ln -sf "$DOTFILES/rofi/gruvbox-$mode.rasi" ~/.config/rofi/gruvbox-current.rasi
ln -sf "$DOTFILES/dunst/dunstrc-$mode" ~/.config/dunst/dunstrc
ln -sf "$DOTFILES/zathura/colors-$mode" ~/.config/zathura/colors
ln -sf "$HOME/dotfiles/.tmux/colors-$mode.conf" ~/.tmux/colors.conf

# Set background color
bsetroot -solid "$( [ "$mode" = "light" ] && echo "#fbf1c7" || echo "#282828" )"
