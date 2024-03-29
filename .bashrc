# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=8000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|*-color|screen) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #export PS1='$(tput setaf 34)[ $(tput bold; tput setaf 28)ltc$(tput setaf 40)@$(tput setaf 28)arch$(tput sgr0; tput setaf 34) ] $(tput setaf 46)[ $(tput bold; tput setaf 40)\w$(tput sgr0; tput setaf 46) ]$(DIRY="\w"; printf "%$(($COLUMNS - 9 - 3 - 5 - ${#DIRY} - 12))s")$(tput bold; tput setaf 34)[ \t ]\n$ $(tput sgr0)'
    #PS1="\[\$([ \$? -eq 0 ] && tput setaf 14 || tput setaf 9)$(tput setab 14)\]\[$(tput bold; tput setaf 0; tput setab 14)\]\u \[\e[m$(tput setaf 14; tput setab 4)\]\[$(tput setaf 0; tput setab 4)\] \w \[\e[m$(tput setaf 4)\]\[\e[m\] "
    export PS1="\[\e[1;34m\]┌──\[\$([ \$? -eq 0 ] && tput setaf 2 || tput setaf 9)\] UwU \n\[\e[1;34m\]└╼ \[\e[0;31m\]\w \[\e[1;34m\]\$ \[\e[m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}[ \u@\h \w\]$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias ll='ls -l'



alias ffrec="ffmpeg -f pulse -i default -f x11grab -video_size 1366x768 -framerate 24 -i :0.0"

alias ffcheese="ffmpeg -f pulse -i default -f x11grab -video_size 1020x574 -framerate 24 -i :0.0+8,107"

alias fflive='ffmpeg -f pulse -i default -f x11grab -framerate 24 -video_size 1366x768 -i :0.0+0,0 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf "format=yuv420p" -g 48 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://live-jfk.twitch.tv/app/$TW_KEY" -loglevel 24'
alias fflu='ffmpeg -f pulse -i default -f x11grab -framerate 24 -video_size 1366x768 -i :0.0+0,0 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf "format=yuv420p" -g 48 -c:a aac -b:a 128k -ar 44100 -f flv "$FFLU_URL" -loglevel 24'

alias ffxeph='ffmpeg -f pulse -i default -f x11grab -framerate 24 -video_size 1024x574 -i :1.0+0,0 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf "format=yuv420p" -g 48 -c:a aac -b:a 128k -ar 44100 -f flv "$FFLU_URL" -loglevel 24'
alias startxeph='Xephyr -br -ac -reset -screen 1024x576 :1 & DISPLAY=:1 berry & DISPLAY=:1 xrdb -load ~/.Xresources'

alias fflivecheese='ffmpeg -f pulse -i default -f x11grab -framerate 24 -video_size 1020x574 -i :0.0+8,107 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf "format=yuv420p" -g 48 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://live-jfk.twitch.tv/app/$TW_KEY" -loglevel 24'

## minecraft version
#alias fflive='ffmpeg -f pulse -i default -f x11grab -framerate 24 -video_size 854x480 -i :2.0+0,55 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf "format=yuv420p" -g 48 -c:a aac -b:a 128k -ar 44100 -f flv "rtmp://live-jfk.twitch.tv/app/$TW_KEY"'

#alias fflivedev="ffmpeg -i /dev/video0 -c:v libx264 -preset veryfast -maxrate 1984k -bufsize 3968k -vf 'format=yuv420p' -g 48 -f flv 'rtmp://live.twitch.tv/app/$TW_KEY'"

# ttm.sh aliases
ttmfile() { curl -F"file=@$1" https://ttm.sh ; }
ttmshort() { curl -F"shorten=$1" https://ttm.sh ; }

# argument aliases
alias mkdir="mkdir -p"
alias t="topydo"

alias stdsize='wc -c | awk '"'"'{print $1/1000"K"}'"'"' '




calcpi() { echo "scale=$1; 4*a(1)" | bc -l ; }



export EDITOR='vim'

