
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

export TERMINAL=urxvt
xrdb -load ~/.Xresources

exec i3


