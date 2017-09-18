# Color prompt
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} %% "

export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE		 # Don't store lines beginning with a space

# Global variables
export GOPATH=$HOME/Dev/go/

# Aliases
#
# Misc
alias vim='nvim'
alias jrnl=' jrnl'
alias task=' task'
alias veracrypt=' veracrypt'
# Basic commands
alias q='exit'
alias pd='pushd'
alias pdd='popd'
alias dr='dirs -v'
alias s='sudo'
# X apps
alias zt='zathura'
# "Tools"
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'
# Other
alias _up='source ~/.zshrc'
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'

# Command completion
#
autoload -Uz compinit
compinit

# Keybinds
#
# Enable emacs-mode
bindkey -e

# Make keybinds work with ru keymap
bindkey '^[а'	forward-word
bindkey '^[и'	backward-word

# Delete words like a bash
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
	    zle backward-kill-word

}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# Plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autopair/zsh-autopair.plugin.zsh
source ~/.config/zsh/zce.zsh/zce.zsh
bindkey "^Xz" zce
