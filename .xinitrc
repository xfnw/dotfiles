
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

export TERMINAL=kitty
xrdb -load ~/.Xresources

exec i3


