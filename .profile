#!/bin/bash



export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=$PATH:/home/ltc/bin

export TERMINAL="kitty"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


[ "$SHELL" -eq "bash"] && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec startx

[[ -n "$TMUX" ]] && source .bashrc

