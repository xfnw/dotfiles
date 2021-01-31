# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export TZ='America/New_York'
export GTK_THEME=Materia-dark
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export CDPATH=:~

export EDITOR=vim
export BROWSER=qutebrowser

# start the ssh agent
[[ -z $SSH_AGENT_PID ]] && eval $(ssh-agent)

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 > /dev/null && exec startx

#[[ -n "$TMUX" ]] && source .zshrc

if [ "$TERM" = "linux" ]; then
    setfont ter-122b
    echo -en "\e[?6c"
    echo -en "\e[?16;14;204c"
    echo -en "\e]P0161510" #black
    echo -en "\e]P84C4635" #darkgrey
    echo -en "\e]P1A32810" #darkred
    echo -en "\e]P9CC3214" #red
    echo -en "\e]P2727A18" #darkgreen
    echo -en "\e]PA8E991E" #green
    echo -en "\e]P3A37720" #brown
    echo -en "\e]PBCC9528" #yellow
    echo -en "\e]P43D6266" #darkblue
    echo -en "\e]PC4C7B7F" #blue
    echo -en "\e]P57A4955" #darkmagenta
    echo -en "\e]PD995B6B" #magenta
    echo -en "\e]P6557A55" #darkcyan
    echo -en "\e]PE6B996B" #cyan
    echo -en "\e]P78E8463" #lightgrey
    echo -en "\e]PFCCBCBE" #white
    clear #for background artifacting
fi
