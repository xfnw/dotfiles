
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

export TERMINAL=kitty
xrdb -load ~/.Xresources

exec i3


