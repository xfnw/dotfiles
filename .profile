#!/bin/bash

[ -f ~/.bashrc ] && source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec i3
