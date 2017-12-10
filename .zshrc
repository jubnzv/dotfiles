# Credentials
export DOCKER_ID_USER="jubnzv1"

# Color prompt
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} %% "

# PATH
export PATH=$PATH:${HOME}/.local/bin/:${HOME}/.local/scripts

# Default editor setup
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
alias grep='ag'
alias ls='ls --color=auto'
# Disable history saving for some commands
alias jrnl=' jrnl'
alias task=' task'
alias veracrypt=' veracrypt'
# Basic commands
alias q='exit'
alias pd='pushd'
alias pdd='popd'
alias pl='dirs -v'
alias pc='dirs -c'
alias s='sudo'
alias svim='sudoedit'
# X apps
alias zt='zathura'
alias mrg='mirage'
# "Tools"
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'
# Docker
alias dps='docker ps'
alias dpsa='docker ps -a'
# Other
alias _up='source ~/.zshrc'
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'

# try to deal ssh connection every second
sssh(){
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

