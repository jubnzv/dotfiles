# Initialize plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autopair/zsh-autopair.plugin.zsh
source ~/.config/zsh/zce.zsh/zce.zsh
bindkey "^Xz" zce

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Credentials
export DOCKER_ID_USER="jubnzv1"

# Color prompt
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} %% "

# Go environment
export GOROOT=~/.local/opt/go
export GOPATH=$HOME/Dev/go/

# PATH
export SCRIPTS_PATH=$HOME/.local/scripts
export PATH=$PATH:$HOME/.local/bin/:$SCRIPTS_PATH:$GOROOT/bin

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

# Enable emacs-mode
bindkey -e

alias vim='nvim'
alias vi='nvim'
alias agp='ag --pager="less -r"'
alias agn='ag -n'
alias agr='ag -r'
alias ls='ls --color=auto'
alias veracrypt=' veracrypt'
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
# Ctags
alias cte='ctags -R -e --extra=+fq --exclude=.git -f TAGS'
alias ct='ctags -R --exclude=.git -f tags'
# Pipenv
alias pps='pipenv shell'
alias ppv='pipenv --venv'
alias ppi='pipenv install'
# Git
alias gl_f='git log -p'
alias gl_n='git log --name-status'
alias gp_master='git push origin master'
alias gp_undo='git push -f origin HEAD^:master'
alias _up='source ~/.zshrc'
alias git_cfg='git --git-dir=$HOME/Sources/dotfiles --work-tree=$HOME'
# Add note
alias nn='vim ~/Org/Notes/'
# Docker
alias dps='docker ps'
alias dpsa='docker ps -a'

# Dynamically change terminal window title
case $TERM in
  (*xterm* | rxvt | rxvt-unicode-256color)
    function precmd {
      print -Pn "\e]0;zsh%L %(1j,%j job%(2j|s|); ,)%~\a"
    }
    function preexec {
      printf "\033]0;%s\a" "$1"
    }
  ;;
esac

# try to deal ssh connection every second
sssh(){
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}

# Command completion
autoload -Uz compinit
compinit

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

# Fuzzy path completion via FZF
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Autojump
. /usr/share/autojump/autojump.sh

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

