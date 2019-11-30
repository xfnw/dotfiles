#!/bin/bash



export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=$PATH:/home/ltc/bin

export PS1="\[$(tput bold)\]\[$(tput setaf 34)\][\[$(tput setaf 28)\]\u\[$(tput setaf 40)\]@\[$(tput setaf 28)\]\h \[$(tput setaf 40)\]\W\[$(tput setaf 34)\]]\[$(tput setaf 28)\]\\$ \[$(tput sgr0)\]"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


[ -f ~/.bashrc ] && source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec startx

[[ -n "$TMUX" ]] && source .bashrc

