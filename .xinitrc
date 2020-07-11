
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

export TERMINAL=urxvt
xfdb -load ~/.Xresources

exec i3


