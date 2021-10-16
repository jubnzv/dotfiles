# {{{ Plugins
if [[ ! -f ~/.zplug/init.zsh ]]; then
	git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

if [[ -f ~/.zplug/init.zsh ]] ; then
    source ~/.zplug/init.zsh

    # Autosuggestions
    zplug "tarruda/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"

    # Syntax highlighting
    zplug "zdharma/fast-syntax-highlighting", defer:3

    # Color parens and highlight matching paren
    export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

    # A plugin to shrink directory paths for brevity and pretty-printing
    zplug "plugins/shrink-path", from:oh-my-zsh

    # Automatically sends out a notification when a long running task has completed
	zplug "MichaelAquilina/zsh-auto-notify", defer:2

    # Install plugins if not all are installed
    if ! zplug check; then
        zplug install
    fi

    # Source plugins and add commands to $PATH
    zplug load
fi
# }}}

fpath=( ~/.zfunc ~/.zsh/zsh-completions/src/ "${fpath[@]}" )

if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init zsh)"
fi

# {{{ Global variables
# Golang workspace location. References:
# https://golang.org/doc/code.html#Workspaces
# https://golang.org/doc/code.html#GOPATH
export GOPATH=$HOME/Dev/go/

# Path to golang installation. Should be set only if multiple versions of Go are using simultaneously.
# See: https://golang.org/doc/install#extra_versions
unset GOROOT

# Path to LLVM build directory
export LLVM=$HOME/Dev/llvm-project/build/bin

export DOTNET_CLI_TELEMETRY_OPTOUT=1
# export DOTNET_ROOT=$HOME/.dotnet

# PATH
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.luarocks/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin/
export PATH=$PATH:$LLVM/
# export PATH=$PATH:$HOME/.dotnet

if [ -f /etc/arch-release ]; then
    export LC_ALL=C
fi

# Default username for https://hub.docker.com
export DOCKER_ID_USER="jubnzv1"

# Shortcuts for common tools
export CPPCHECK=$HOME/Dev/cppcheck/
export FLAMEGRAPH=$HOME/Dev/tools/FlameGraph

# Debian tools
export QUILT_PATCHES=debian/patches

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
# Make Java UI not so ugly.
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true
# -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
# -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Configure Qt theme with qt5ct
# export QT_QPA_PLATFORM='wayland;xcb'
export QT_QPA_PLATFORMTHEME='qt5ct'

export EDITOR="nvim"
export DEBEMAIL="jubnzv@gmail.com"
export ALTERNATE_EDITOR="nvim-qt"
export MANPAGER="nvim -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -"
export TERMCMD="alacritty"
export TERMINAL="alacritty -e"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PYFLAKES_BUILTINS='_' # Don't treat i18n '_' as error
export PYTHONSTARTUP=~/.pythonrc

# OCaml environment
if [[ -x "$(command -v opam)" ]]; then
  eval "$(opam config env)"
fi
# }}}

# {{{ Prompt & colors
autoload -U colors && colors # Enable colorized prompt
export CLICOLORS=1

# Setup LS_COLORS https://github.com/trapd00r/LS_COLORS
if [ -f $HOME/.zsh/dircolors ]; then
  eval $( dircolors -b $HOME/.zsh/dircolors )
else
  export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;3 2"
fi

# Use same colors for autocompletion
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -Uz vcs_info        # Show git branch name
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '  %b'
setopt prompt_subst

function precmd() {
    vcs_info
}

# Set another cursor color when running inside tmux
# zle-line-init () {
# if [[ -z "$TMUX" ]]; then
#     echo -ne "\033]12;Grey\007"
# fi
# }
# zle -N zle-line-init

PS1='%{$fg[yellow]%}$(shrink_path -f)%{$reset_color%}%{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%} '
# }}}

# {{{ zsh options
# Spell check commands and offer correction (pdw > pwd)
setopt correct

# Turn off all beeps
unsetopt BEEP
setopt no_beep

# http://zsh.sourceforge.net/Intro/intro_6.html
DIRSTACKSIZE=8

# Perform cd if command is directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Do not push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# No pushd messages
setopt pushd_silent

# Disable mail checking: use mail client instead
export MAILCHECK=0

# Disable flow control
stty -ixon

# {{{ History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=1000000
setopt incappendhistory
setopt sharehistory
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Don't store lines beginning with a space
setopt HIST_IGNORE_SPACE
alias history='history -i'
# }}}

# }}}

# {{{ Aliases
# Common
alias q='exit'
alias :q='exit'
alias :qa='exit'
alias pd='pushd'
alias pdd='popd'
alias s='sudo'
alias less='less -Q' # Turn off beeps
alias rp='realpath'
alias grep='grep --color=auto'
alias minicom_usb0='sudo minicom -D /dev/ttyUSB0 -C /tmp/minicom.log'
alias minicom_usb1='sudo minicom -D /dev/ttyUSB1 -C /tmp/minicom.log'
zt() { zathura $1 2>&1 >/dev/null & }
alias j='z'
jj() { z "$@"; [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}" }
alias tree='tree -C'
alias r='ranger'
alias getip='dig +short myip.opendns.com @resolver1.opendns.com'
lfind() { find . -iname $@ 2>/dev/null }

alias gdb='gdb -q'

# Debian tools
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"

# vim
alias v='nvim'
alias vim='nvim'
alias vO='nvim -O' # Open in vertical splits
alias vo='nvim -o' # Open in horizontal splits
alias vc='nvim -u NONE'

# copy working directory to clipboard
alias cpwd='pwd | tr -d "\n" | xsel -ib'

mkcd() {
    [[ $# -gt 1 ]] && return 1
    mkdir -p "$1" && cd "$1" || return 1
    [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}"
}

# git
alias g='git'
alias gb='git branch'
alias gatzf='tar cfvz $(basename ~+).tar.gz --exclude .git .'
alias gatz='git archive master --format=tar.gz > "$(basename ~+)".tar.gz'
alias gaz='git archive master --format=zip > "$(basename ~+)".zip'
alias gf='git fetch --prune'
alias gfa='git fetch --prune --all'
alias gsm='git submodule'
alias gsmi='git submodule update --init --recursive'
alias gsmy='git submodule sync'
alias gclean='git clean -fidx'
gcd() {
    [[ $# -ne 1 ]] && return 1
    url=`echo $1 | grep -P 'https?://[a-zA-Z.-]+/[a-zA-Z-]+/[a-zA-Z-]+' -o`
    [[ "${url}" == "" ]] && return 1
    git clone "$url" && cd "${url##*/}" || return 1
    [[ $TMUX ]] && tmux rename-window "#{b:pane_current_path}"
}

alias -g KE="2>&1"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g O="> output.txt"
alias -g G='| rg'
alias -g L="|& less"
alias -g V="| nvim -"
alias -g ND="notify-send 'Done' ''"
alias -g U="echo -e '\a'"
alias -g CP="xclip -selection clipboard"
alias -g IR="i3-msg 'workspace back_and_forth' >/dev/null"

# Perform operation using fzf. Examples:
#   find /usr/include -name "test.h" F nvim
#   find /usr/lib -name "test.so.*" F readelf -h
if [[ -z "$TMUX" ]]; then
    alias -g F="| fzf --multi --cycle | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
else
    alias -g F="| fzf-tmux --multi --tac | tr '\n' '\0' | xargs --no-run-if-empty -0 sh -c '\$0 \"\$@\" </dev/tty' "
fi

# python
alias vs='source venv/bin/activate'
alias py2='python2'
alias py3='python3'
alias ipy='ipython3'
alias ipy2='ipython'
alias ipy3='ipython3'
alias venv2='virtualenv venv --system-site-packages --python=/usr/bin/python2'
alias venv3='virtualenv venv --system-site-packages --python=/usr/bin/python3'

# ls
alias ls='ls --color=auto'
alias ll='ls -oh'

# diffs
alias diffdir='diff -ENwbur'
alias cpd='cpdiff'

# {{{ taskwarrior
if [[ -x "$(command -v task)" ]]; then
    alias t="task"                        # Default `task next` report
    alias tt="t recent"                   # Recently added tasks
    alias tstopall="t rc.gc=off +ACTIVE _ids | xargs task rc.gc=off rc.confirmation=no rc.bulk=yes stop"
    alias tschedd='task sched.before:today+1d -COMPLETED -DELETED -DUETODAY +PENDING'
    alias tdued='task due.before:today+1d -COMPLETED -DELETED +PENDING'
    alias tdoned='t end:today status:completed all'
    alias tdonew='t end.after:today-7d status:completed all'
    alias tdonem='t end.after:today-30d status:completed all'
    alias bwp="bugwarrior-pull"

    # Simplify work with tasks marked with +event
    alias tel="task +event"
    tea() {
        if [ $# -ne 2 ]; then
            echo "Usage: tea DESCRIPTION DATE"
            return 1
        fi
        task add +event "$1" due:"$2" until:due+1d
    }
fi

if [[ -x "$(command -v task)" ]]; then
    cal() {
        task calendar
    }
else
    alias cal="cal -3"
fi
# }}}

alias exrm="exim4 -bp | grep frozen| awk '{print $3}' | xargs exim4 -Mrm"

# Sequence that disables cursor blinking
alias stopblink="printf '\033[?12l'"

# Tools
alias psmem="sudo $(which ps_mem.py)"
# }}}

# {{{ Functions

# Modprobe modules used by VirtualBox
modprobe_vb() {
    sudo modprobe vboxguest
    sudo modprobe vboxnetadp
    sudo modprobe vboxnetflt
}

mount_iso() {
    sudo mkdir -pv /mnt/iso/
    sudo mount -o loop $1 /mnt/iso/ 2>/dev/null
}

# Try to establish ssh connection for every second
sssh() {
  while true; do command ssh "$@"; [ $? -ne 255 ] && break || sleep 1; done
}
# }}}

# {{{ Keybindings
bindkey -e                        # Enable emacs-mode

autoload -Uz compinit && compinit # Command completion

bindkey '^[а'	emacs-forward-word
bindkey '^[и'	emacs-backward-word
bindkey '\ef'   emacs-forward-word
bindkey '\eb'   emacs-backward-word

# Ctrl+backspace to delete the previous word to slash
#
# References:
# + https://unix.stackexchange.com/questions/313806/zsh-make-altbackspace-stop-at-non-alphanumeric-characters
# + https://unix.stackexchange.com/questions/258656/how-can-i-delete-to-a-slash-or-a-word-in-zsh
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^H' backward-kill-dir

bindkey -s "\ep"  "^Qvimfzf .^J"            # Select file with fzf and open it in vim.
bindkey -s "\ev"  "^Qv .^J"                 # Open editor in current directory
bindkey -s '\C-x\C-d' '$(date +%Y-%m-%d)'
# }}}

# {{{ fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# {{{ Gruvbox color scheme
# https://github.com/nicodebo/base16-fzf/blob/master/bash/base16-gruvbox-dark-soft.config
_gen_fzf_default_opts() {
local color00='#32302f'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
}

_gen_fzf_default_opts
# }}}

export FZF_DEFAULT_OPTS=${FZF_DEFAULT_OPTS}" --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel,esc:cancel"

if [[ "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --follow'
    export FZF_CTRL_T_COMMAND='fd --type file --follow'
fi

# Search ctags.
# Creds: https://github.com/vbauerster/dotfiles/blob/master/.functions.zsh
function fzf-ctags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
zle -N fzf-ctags
bindkey "^[t" fzf-ctags

function fzf-delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}

function fzf-rga() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}
zle -N fzf-rga
bindkey "^[r" fzf-rga
# }}}

# {{{ auto-notify plugin configuration
export AUTO_NOTIFY_THRESHOLD=600
export AUTO_NOTIFY_TITLE="%command: done with %exit_code"
export AUTO_NOTIFY_BODY="Elapsed time: %elapsed seconds"
export AUTO_NOTIFY_WHITELIST=("apt-get" "docker" "rsync" "scp" "cp" "mv" "rm" "git"
                              "cmake" "ocamlbuild" "make" "ninja" "dune"
                              "cabal"
                              "borg-linux64" "aria2" "frama-c"
                              "chk1" "cppcheck" "perf" "mprof" "svn" "opam" "sync-ebook.sh")
export AUTO_NOTIFY_IGNORE=("docker exec" "docker-compose")
export AUTO_NOTIFY_EXPIRE_TIME=2000
# }}}

# {{{ Show current directory in the X window title
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~} - zsh"
}
function set-title-preexec() {
  printf "\e]2;%s\a" "$1 - zsh"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
# }}}

# {{{ Start ssh-agent
function start_ssh_agent() {
	local lifetime
	local -a identities

	zstyle -s :plugins:ssh-agent lifetime lifetime

	ssh-agent -s ${lifetime:+-t} ${lifetime} | sed 's/^echo/#echo/' >! $ssh_environment
	chmod 600 $ssh_environment
	source $ssh_environment > /dev/null

	zstyle -a :plugins:ssh-agent identities identities

	echo starting ssh-agent...
	ssh-add $HOME/.ssh/${^identities}
}

# ssh_environment="$HOME/.ssh/environment-$HOST"
# 
# if [[ -f "$ssh_environment" ]]; then
# 	source $ssh_environment > /dev/null
# 	ps x | grep ssh-agent | grep -q $SSH_AGENT_PID || {
# 		start_ssh_agent
# 	}
# else
# 	start_ssh_agent
# fi
# }}}

# {{{ Utilities
# Shell commands usage statistics
function zsh_stats() {
	fc -l 1 | \
		awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
		grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}
# }}}

# Auto start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

# vim:foldmethod=marker:foldenable:foldlevel=0:sw=4:tw=120
