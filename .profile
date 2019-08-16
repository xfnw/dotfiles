#!/bin/bash

[ -f ~/.bashrc ] && .bashrc

[ "$(tty)" = "/dev/tty1" ] ^^ ! pgrep -x i3 > /dev/null && exec i3
