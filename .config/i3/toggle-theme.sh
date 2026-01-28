#!/bin/bash
# Toggle between dark and light theme across all desktop components

DOTFILES="$HOME/dotfiles/.config"
STATE_FILE="$HOME/.config/theme-mode"

current=$(cat "$STATE_FILE" 2>/dev/null || echo "dark")
mode=$( [ "$current" = "dark" ] && echo "light" || echo "dark" )
echo "$mode" > "$STATE_FILE"

# Kitty - built-in theme switching
kitty +kitten themes --reload-in=all "Gruvbox Material ${mode^}" 2>/dev/null || \
kitty +kitten themes --reload-in=all "Gruvbox ${mode^}" 2>/dev/null

# Neovim - send to all running instances
for sock in /run/user/$(id -u)/nvim.*/0; do
    [ -S "$sock" ] && nvim --server "$sock" --remote-send ":set background=$mode<CR>" 2>/dev/null &
done

# i3 - symlink + reload
ln -sf "$DOTFILES/i3/colors-$mode.conf" ~/.config/i3/colors.conf
i3-msg reload

# Polybar - symlink + restart
ln -sf "$DOTFILES/polybar/colors-$mode.ini" ~/.config/polybar/colors.ini
polybar-msg cmd restart 2>/dev/null || ~/.config/polybar/launch.sh

# Rofi - symlink only (loads on demand)
ln -sf "$DOTFILES/rofi/gruvbox-$mode.rasi" ~/.config/rofi/gruvbox-current.rasi

# Dunst - symlink + restart
ln -sf "$DOTFILES/dunst/dunstrc-$mode" ~/.config/dunst/dunstrc
killall dunst 2>/dev/null

# Zathura - symlink (running instances won't update)
ln -sf "$DOTFILES/zathura/colors-$mode" ~/.config/zathura/colors

# tmux - symlink + reload all servers (no background to avoid race condition)
ln -sf "$HOME/dotfiles/.tmux/colors-$mode.conf" ~/.tmux/colors.conf
if tmux list-sessions &>/dev/null; then
    tmux source-file ~/.tmux/colors.conf
fi

# GTK via gsettings
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita$( [ "$mode" = "dark" ] && echo "-dark" )" 2>/dev/null
gsettings set org.gnome.desktop.interface color-scheme "prefer-$mode" 2>/dev/null

# Background
bsetroot -solid "$( [ "$mode" = "light" ] && echo "#fbf1c7" || echo "#282828" )"

notify-send "Theme" "Switched to $mode mode" -t 2000
