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
for sock in /run/user/$(id -u)/nvim.*.0; do
    [ -S "$sock" ] && nvim --server "$sock" --remote-send ":set background=$mode | colorscheme gruvbox<CR>" 2>/dev/null &
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

# Claude Code - update theme in preferences
if [ -f ~/.claude.json ]; then
    jq --arg theme "$mode" '.theme = $theme' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
fi

# GTK theme (Breeze)
GTK_THEME=$( [ "$mode" = "dark" ] && echo "Breeze-Dark" || echo "Breeze" )
GTK_ICONS="breeze"

sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME/" ~/.config/gtk-3.0/settings.ini
sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$GTK_ICONS/" ~/.config/gtk-3.0/settings.ini
sed -i "s/^gtk-theme-name=.*/gtk-theme-name=\"$GTK_THEME\"/" ~/.gtkrc-2.0
sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$GTK_ICONS\"/" ~/.gtkrc-2.0
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" 2>/dev/null
gsettings set org.gnome.desktop.interface color-scheme "prefer-$mode" 2>/dev/null

# Background
bsetroot -solid "$( [ "$mode" = "light" ] && echo "#fbf1c7" || echo "#282828" )"

notify-send "Theme" "Switched to $mode mode" -t 2000
