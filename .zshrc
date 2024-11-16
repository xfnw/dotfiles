# The following lines were added by compinstall

plot() { gnuplot -p -e 'set object rectangle from screen -1,-1 to screen 1,1 behind fillcolor rgb "black" fillstyle solid noborder; set border lw 1 lc rgb "white"; set xtics textcolor rgb "white"; set xlabel "X" textcolor rgb "white"; set ylabel "Y" textcolor rgb "white"; set key textcolor rgb "white"; plot for [col='$2'] "'$1'" using '$3':col title "'$5'" with '$4' lw 2 pt 7' ; }
smoothplot() { gnuplot -p -e 'set object rectangle from screen -1,-1 to screen 1,1 behind fillcolor rgb "black" fillstyle solid noborder; set border lw 1 lc rgb "white"; set xtics textcolor rgb "white"; set xlabel "X" textcolor rgb "white"; set ylabel "Y" textcolor rgb "white"; set key textcolor rgb "white"; plot for [col='$2'] "'$1'" using '$3':col smooth cspline title "'$5'" with '$4' lw 2 pt 7' ; }

calcpi() { echo "scale=$1; 16*a(1/5)-4*a(1/239)" | bc -l ; }
calcbd() { echo "h=sqrt($1*l(4))+1; scale=0; h/1" | bc -l ; }
vhsify() { ffmpeg -i "$1" -vf fps=24,scale="(iw*sar)*max(640/(iw*sar)\,480/ih):ih*max(640/(iw*sar)\,480/ih)",crop=640:480,setsar=1:1,convolution="-2 -1 0 -1 1 1 0 1 2:-2 -1 0 -1 1 1 0 1 2:-2 -1 0 -1 1 1 0 1 2:-2 -1 0 -1 1 1 0 1 2",curves="0/0 0.5/0.58 1/1",rgbashift=rh=-1:gh=1 -preset veryfast -c:a "${3:-copy}" "$2" ; }
deshake() { ffmpeg -i "$1" -vf "format=rgb24,split[a][b];[a]deshake=rx=64:ry=64:edge=0,colorkey=0x008000:blend=0:similarity=.2[a];[b]drawbox=color=black:t=fill[b];[b][a]overlay" -c:a copy "$2" ; }
ffdiff() { ffmpeg -i "$1" -c:a "${3:-copy}" -filter_complex "tblend=all_mode=${4:-grainextract},setsar=1" -vsync vfr "$2" ; }
ffdiffb() { ffmpeg -i "$1" -c:a "${3:-copy}" -filter_complex "tblend=all_mode=${4:-grainextract},curves=all=0/1 .5/0 1/1,setsar=1" -vsync vfr "$2" ; }
ffdiffc() { ffmpeg -i "$1" -c:a "${3:-copy}" -filter_complex "split[orig][diff];[diff]tblend=all_mode=${4:-grainextract},curves=all=0/1 .5/0 1/1[diff];[orig][diff]blend=all_mode=${5:-grainmerge},setsar=1" -vsync vfr "$2" ; }
datamosh() { ffmpeg -i "$1" -c copy -bsf:v noise=drop='gt(pts/tb\,30)*key' "$2" ; }
dither() { magick "$1" -filter box -resize 700 -ordered-dither o4x4,2 "$2" ; }
ditherc() { magick "$1" -colorspace RGB -filter box -resize 700 -ordered-dither o4x4,2 -colorspace sRGB "$2" ; }
9serve() { socat TCP-LISTEN:"$1",reuseaddr,fork SYSTEM:"9pex $2" ; }
unidec() { echo -n "$@" | uniname -bcpe | tail -n +2 | awk -F'  ' '{gsub("^0*","",$1); printf "U+%s %s (%s)\n",$1,$5,$2}' ; }

base58gen() { echo $(base64 /dev/urandom | tr -d "\n/+Il0O$2" | head -c ${$(($1/5.85+1))%.*}) ; }
vid() { echo "VULP$(base64 /dev/urandom | tr -d "\n/+I0Oa-z" | head -c 17)" ; }
fur() { sed -i 's/\($Fur: \)[[:print:]]* \$/\1'"$1 $(date -uIs | cut -c-19)Z $USER $/" "$1" ; }
tuch() { touch "$@" ; chmod 755 "$@" ; ${EDITOR:-vim} "$@" ; }
rot13() { tr 'a-zA-Z' 'n-za-mN-ZA-M' ; }
putdir(){ find "${@:2}" | while IFS= read fname ; do curl -X PUT --data-binary "@$fname" "$1$fname" || ls -l -- "$fname" | curl -X PUT --data-binary @- "$1$fname/" ; done ; }
deldir(){ find "${@:2}" | while IFS= read fname ; do curl -X DELETE "$1$fname" ; done ; }
tapemeasure() { du -b "$@" | awk '{printf "%6.2f\t", $1/('"$(du -b "$1" | cut -f1)"')*100; print}' | sort -nr ; }
meili() { curl -X POST "http://$1:7700/indexes/$2?$3" -H 'Content-Type: application/json' --data-binary @- ; }
meilil() { curl -X POST "http://$1:7700/indexes/$2?$3" -H 'Content-Type: application/x-ndjson' --data-binary @- ; }
meiliset() { curl -X PATCH "http://$1:7700/indexes/$2/settings" -H 'Content-Type: application/json' --data-binary @- ; }
meilit() { curl "http://$1:7700/tasks/$2" ; }

alias hexcat="catgirl -h irc.libera.chat -n xfnwtest -ec cert.pem -u"

alias warc="wget -rpkm --warc-cdx --warc-file"
alias ytdl="yt-dlp --extract-audio --audio-format mp3"
alias mpvferret="mpv --config=no --quiet --vo=tct --lavfi-complex='[aid1]asplit[ao][a1];[a1]avectorscope=r=25:m=lissajous_xy:bc=100:gc=100:rc=75:bf=5:gf=3:rf=1:mirror=y:zoom=1[vo]'"
alias mpvcqt="mpv --config=no --lavfi-complex='[aid1]asplit[ao][a1];[a1]showcqt=r=25[vo]'"
alias mpvscope="mpv --config=no --background=color --lavfi-complex='[aid1]asplit[ao][a1];[a1]avectorscope=r=25:m=lissajous_xy:bc=100:gc=100:rc=75:bf=255:gf=80:rf=255:mirror=y:draw=line:zoom=1[vo]'"
alias mpvscopedot="mpv --config=no --background=color --lavfi-complex='[aid1]asplit[ao][a1];[a1]avectorscope=r=25:m=lissajous_xy:bc=100:gc=100:rc=75:bf=255:gf=80:rf=255:mirror=y:zoom=1[vo]'"
alias ssk="ssh-keygen -lf ~/.ssh/known_hosts | grep"
alias qqemu="qemu-system-x86_64 -display gtk,zoom-to-fit=on -nic user -enable-kvm"
alias gitversion='printf "r%s.%s\n" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"'
alias gitpretty='git log --graph --pretty="%Cred%h%Creset %Cblue%G?%Creset %C(green)%an <%ae> %C(white)%ar%Creset%Cred% D%Creset%n%w(50,1,1)%B"'
alias raged="rage -i ~/.age/private -d"
alias sshemacs="ssh -R ~/.sshemacs:${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/emacs/server"
alias sstripr='sstrip -z target/**/release/^*.*(.)'
alias cch="cppcheck --enable=all --suppress=missingIncludeSystem ."
alias ahex='hexdump -e '"'"'"%4.4_ax:" 8/1 "%3.1X" "\n"'"'"
alias after="at now +"
alias ddiff="datediff -f '%d days, %H hours, %M minutes, %S seconds'"
alias m='eval $(xdotool getmouselocation --shell)'
alias tess='tesseract ~/Pictures/scrot/$(ls -t ~/Pictures/scrot | head -n1) -'
alias irclen="tr '\3' 'c' | LC_ALL=C awk '{print length}' | sort -nr | head -n1"
alias ncdu='ncdu --color off'

alias sydi="sudo"
alias rn="rm -i"

#autoload -Uz compinit
#compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
WORDCHARS='*?_-.[]~=&#$%^(){}<>' 

setopt autocd
unsetopt nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

# why wont it run my profile lol
source ~/.profile

#f1# are we running within an utf environment?
function isutfenv () {
    case "$LANG $CHARSET $LANGUAGE" in
        *utf*) return 0 ;;
        *UTF*) return 0 ;;
        *)     return 1 ;;
    esac
}

# check for user, if not running as root set $SUDO to sudo
(( EUID != 0 )) && SUDO='sudo' || SUDO=''

# change directory to home on first invocation of zsh
# important for rungetty -> autologin
# Thanks go to Bart Schaefer!
function checkhome () {
    if [[ -z "$ALREADY_DID_CD_HOME" ]] ; then
        export ALREADY_DID_CD_HOME=$HOME
        cd
    fi
}

# check for zsh v3.1.7+

if ! [[ ${ZSH_VERSION} == 3.1.<7->*      \
     || ${ZSH_VERSION} == 3.<2->.<->*    \
     || ${ZSH_VERSION} == <4->.<->*   ]] ; then

    printf '-!-\n'
    printf '-!- In this configuration we try to make use of features, that only\n'
    printf '-!- require version 3.1.7 of the shell; That way this setup can be\n'
    printf '-!- used with a wide range of zsh versions, while using fairly\n'
    printf '-!- advanced features in all supported versions.\n'
    printf '-!-\n'
    printf '-!- However, you are running zsh version %s.\n' "$ZSH_VERSION"
    printf '-!-\n'
    printf '-!- While this *may* work, it might as well fail.\n'
    printf '-!- Please consider updating to at least version 3.1.7 of zsh.\n'
    printf '-!-\n'
    printf '-!- DO NOT EXPECT THIS TO WORK FLAWLESSLY!\n'
    printf '-!- If it does today, you'\''ve been lucky.\n'
    printf '-!-\n'
    printf '-!- Ye been warned!\n'
    printf '-!-\n'

    function zstyle () { : }
fi

# autoload wrapper - use this one instead of autoload directly
# We need to define this function as early as this, because autoloading
# 'is-at-least()' needs it.
function zrcautoload () {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( ffound = 0 ))
    for fdir in ${fpath} ; do
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 ))
    done

    (( ffound == 0 )) && return 1
    if [[ $ZSH_VERSION == 3.1.<6-> || $ZSH_VERSION == <4->* ]] ; then
        autoload -U ${ffile} || return 1
    else
        autoload ${ffile} || return 1
    fi
    return 0
}

# The following is the ‘add-zsh-hook’ function from zsh upstream. It is
# included here to make the setup work with older versions of zsh (prior to
# 4.3.7) in which this function had a bug that triggers annoying errors during
# shell startup. This is exactly upstreams code from f0068edb4888a4d8fe94def,
# with just a few adjustments in coding style to make the function look more
# compact. This definition can be removed as soon as we raise the minimum
# version requirement to 4.3.7 or newer.
function add-zsh-hook () {
    # Add to HOOK the given FUNCTION.
    # HOOK is one of chpwd, precmd, preexec, periodic, zshaddhistory,
    # zshexit, zsh_directory_name (the _functions subscript is not required).
    #
    # With -d, remove the function from the hook instead; delete the hook
    # variable if it is empty.
    #
    # -D behaves like -d, but pattern characters are active in the function
    # name, so any matching function will be deleted from the hook.
    #
    # Without -d, the FUNCTION is marked for autoload; -U is passed down to
    # autoload if that is given, as are -z and -k. (This is harmless if the
    # function is actually defined inline.)
    emulate -L zsh
    local -a hooktypes
    hooktypes=(
        chpwd precmd preexec periodic zshaddhistory zshexit
        zsh_directory_name
    )
    local usage="Usage: $0 hook function\nValid hooks are:\n  $hooktypes"
    local opt
    local -a autoopts
    integer del list help
    while getopts "dDhLUzk" opt; do
        case $opt in
        (d) del=1 ;;
        (D) del=2 ;;
        (h) help=1 ;;
        (L) list=1 ;;
        ([Uzk]) autoopts+=(-$opt) ;;
        (*) return 1 ;;
        esac
    done
    shift $(( OPTIND - 1 ))
    if (( list )); then
        typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
        return $?
    elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 )); then
        print -u$(( 2 - help )) $usage
        return $(( 1 - help ))
    fi
    local hook="${1}_functions"
    local fn="$2"
    if (( del )); then
        # delete, if hook is set
        if (( ${(P)+hook} )); then
            if (( del == 2 )); then
                set -A $hook ${(P)hook:#${~fn}}
            else
                set -A $hook ${(P)hook:#$fn}
            fi
            # unset if no remaining entries --- this can give better
            # performance in some cases
            if (( ! ${(P)#hook} )); then
                unset $hook
            fi
        fi
    else
        if (( ${(P)+hook} )); then
            if (( ${${(P)hook}[(I)$fn]} == 0 )); then
                set -A $hook ${(P)hook} $fn
            fi
        else
            set -A $hook $fn
        fi
        autoload $autoopts -- $fn
    fi
}

# Load is-at-least() for more precise version checks Note that this test will
# *always* fail, if the is-at-least function could not be marked for
# autoloading.
zrcautoload is-at-least || function is-at-least () { return 1 }

# set some important options (as early as possible)

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history

# import new commands from the history file also in other zsh-session
setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# use zsh style word splitting
setopt noshwordsplit

# don't error out when unset parameters are used
setopt unset

# setting some default values
NOCOR=${NOCOR:-0}
NOMENU=${NOMENU:-0}
NOPRECMD=${NOPRECMD:-0}
GRML_DISPLAY_BATTERY=${GRML_DISPLAY_BATTERY:-${BATTERY:-0}}
GRMLSMALL_SPECIFIC=${GRMLSMALL_SPECIFIC:-1}
ZSH_NO_DEFAULT_LOCALE=${ZSH_NO_DEFAULT_LOCALE:-0}

typeset -ga ls_options
typeset -ga grep_options

# Colors on GNU ls(1)
if ls --color=auto / >/dev/null 2>&1; then
    ls_options+=( --color=auto )
# Colors on FreeBSD and OSX ls(1)
elif ls -G / >/dev/null 2>&1; then
    ls_options+=( -G )
fi

# Natural sorting order on GNU ls(1)
# OSX and IllumOS have a -v option that is not natural sorting
if ls --version |& grep -q 'GNU' >/dev/null 2>&1 && ls -v / >/dev/null 2>&1; then
    ls_options+=( -v )
fi

# Color on GNU and FreeBSD grep(1)
if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
    grep_options+=( --color=auto )
fi

# utility functions
# this function checks if a command exists and returns either true
# or false. This avoids using 'which' and 'whence', which will
# avoid problems with aliases for which on certain weird systems. :-)
# Usage: check_com [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
function check_com () {
    emulate -L zsh
    local -i comonly gatoo
    comonly=0
    gatoo=0

    if [[ $1 == '-c' ]] ; then
        comonly=1
        shift 1
    elif [[ $1 == '-g' ]] ; then
        gatoo=1
        shift 1
    fi

    if (( ${#argv} != 1 )) ; then
        printf 'usage: check_com [-c|-g] <command>\n' >&2
        return 1
    fi

    if (( comonly > 0 )) ; then
        (( ${+commands[$1]}  )) && return 0
        return 1
    fi

    if     (( ${+commands[$1]}    )) \
        || (( ${+functions[$1]}   )) \
        || (( ${+aliases[$1]}     )) \
        || (( ${+reswords[(r)$1]} )) ; then
        return 0
    fi

    if (( gatoo > 0 )) && (( ${+galiases[$1]} )) ; then
        return 0
    fi

    return 1
}

# creates an alias and precedes the command with
# sudo if $EUID is not zero.
function salias () {
    emulate -L zsh
    local only=0 ; local multi=0
    local key val
    while getopts ":hao" opt; do
        case $opt in
            o) only=1 ;;
            a) multi=1 ;;
            h)
                printf 'usage: salias [-hoa] <alias-expression>\n'
                printf '  -h      shows this help text.\n'
                printf '  -a      replace '\'' ; '\'' sequences with '\'' ; sudo '\''.\n'
                printf '          be careful using this option.\n'
                printf '  -o      only sets an alias if a preceding sudo would be needed.\n'
                return 0
                ;;
            *) salias -h >&2; return 1 ;;
        esac
    done
    shift "$((OPTIND-1))"

    if (( ${#argv} > 1 )) ; then
        printf 'Too many arguments %s\n' "${#argv}"
        return 1
    fi

    key="${1%%\=*}" ;  val="${1#*\=}"
    if (( EUID == 0 )) && (( only == 0 )); then
        alias -- "${key}=${val}"
    elif (( EUID > 0 )) ; then
        (( multi > 0 )) && val="${val// ; / ; sudo }"
        alias -- "${key}=sudo ${val}"
    fi

    return 0
}

# Check if we can read given files and source those we can.
function xsource () {
    if (( ${#argv} < 1 )) ; then
        printf 'usage: xsource FILE(s)...\n' >&2
        return 1
    fi

    while (( ${#argv} > 0 )) ; do
        [[ -r "$1" ]] && source "$1"
        shift
    done
    return 0
}

# Check if we can read a given file and 'cat(1)' it.
function xcat () {
    emulate -L zsh
    if (( ${#argv} != 1 )) ; then
        printf 'usage: xcat FILE\n' >&2
        return 1
    fi

    [[ -r $1 ]] && cat $1
    return 0
}

# Remove these functions again, they are of use only in these
# setup files. This should be called at the end of .zshrc.
function xunfunction () {
    emulate -L zsh
    local -a funcs
    local func
    funcs=(salias xcat xsource xunfunction zrcautoload zrcautozle)
    for func in $funcs ; do
        [[ -n ${functions[$func]} ]] \
            && unfunction $func
    done
    return 0
}

# this allows us to stay in sync with grml's zshrc and put own
# modifications in ~/.zshrc.local
function zrclocal () {
    xsource "/etc/zsh/zshrc.local"
    xsource "${ZDOTDIR:-${HOME}}/.zshrc.local"
    return 0
}

# locale setup
if (( ZSH_NO_DEFAULT_LOCALE == 0 )); then
    xsource "/etc/default/locale"
fi

for var in LANG LC_ALL LC_MESSAGES ; do
    [[ -n ${(P)var} ]] && export $var
done
builtin unset -v var

# set some variables
if check_com -c vim ; then
#v#
    export EDITOR=${EDITOR:-vim}
else
    export EDITOR=${EDITOR:-vi}
fi

#v#
export PAGER=${PAGER:-less}

#v#
export MAIL=${MAIL:-/var/mail/$USER}

# color setup for ls:
check_com -c dircolors && eval $(dircolors -b)
# color setup for ls on OS X / FreeBSD:
export CLICOLOR=1


# load our function and completion directories
for fdir in /usr/share/grml/zsh/completion /usr/share/grml/zsh/functions; do
    fpath=( ${fdir} ${fdir}/**/*(/N) ${fpath} )
done
typeset -aU ffiles
ffiles=(/usr/share/grml/zsh/functions/**/[^_]*[^~](N.:t))
(( ${#ffiles} > 0 )) && autoload -U "${ffiles[@]}"
unset -v fdir ffiles

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# mailchecks
MAILCHECK=30

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5

# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# Load a few modules
for mod in parameter complist deltochar mathfunc ; do
    zmodload -i zsh/${mod} 2>/dev/null || print "Notice: no ${mod} available :("
done && builtin unset -v mod

# autoload zsh modules when they are referenced
    zmodload -a  zsh/stat    zstat
    zmodload -a  zsh/zpty    zpty
    zmodload -ap zsh/mapfile mapfile

# completion system
COMPDUMPFILE=${COMPDUMPFILE:-${ZDOTDIR:-${HOME}}/.zcompdump}
if zrcautoload compinit ; then
    typeset -a tmp
    zstyle -a ':grml:completion:compinit' arguments tmp
    compinit -d ${COMPDUMPFILE} "${tmp[@]}" || print 'Notice: no compinit available :('
    unset tmp
else
    print 'Notice: no compinit available :('
    function compdef { }
fi

# completion system

# called later (via is4 && grmlcomp)
# note: use 'zstyle' for getting current settings
#         press ^xh (control-x h) for getting tags in context; ^x? (control-x ?) to run complete_debug with trace output
function grmlcomp () {
    # TODO: This could use some additional information

    # Make sure the completion system is initialised
    (( ${+_comps} )) || return 1

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    # zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    if [[ "$NOMENU" -eq 0 ]] ; then
        # if there are more than 5 options allow selecting from a menu
        zstyle ':completion:*'               menu select=5
    else
        # don't use any menus at all
        setopt no_auto_menu
    fi

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose false

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # Search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin            \
                                               /usr/X11R6/bin

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..

    # run rehash on completion so new installed program are found automatically:
    function _force_rehash () {
        (( CURRENT == 1 )) && rehash
        return 1
    }

    ## correction
    # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
    if [[ "$NOCOR" -gt 0 ]] ; then
        zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
        setopt nocorrect
    else
        # try to be smart about when to use what completer...
        setopt correct
        zstyle -e ':completion:*' completer '
            if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
                _last_try="$HISTNO$BUFFER$CURSOR"
                reply=(_complete _match _ignored _prefix _files)
            else
                if [[ $words[1] == (rm|mv) ]] ; then
                    reply=(_complete _files)
                else
                    reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
                fi
            fi'
    fi

    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

    # Some functions, like _apt and _dpkg, are very slow. We can use a cache in
    # order to speed things up
    if [[ ${GRML_COMP_CACHING:-yes} == yes ]]; then
        GRML_COMP_CACHE_DIR=${GRML_COMP_CACHE_DIR:-${ZDOTDIR:-$HOME}/.cache}
        if [[ ! -d ${GRML_COMP_CACHE_DIR} ]]; then
            command mkdir -p "${GRML_COMP_CACHE_DIR}"
        fi
        zstyle ':completion:*' use-cache  yes
        zstyle ':completion:*:complete:*' cache-path "${GRML_COMP_CACHE_DIR}"
    fi

    # host completion
        [[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
        [[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
        [[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

    local localname
    if check_com hostname ; then
      localname=$(hostname)
    elif check_com hostnamectl ; then
      localname=$(hostnamectl --static)
    else
      localname="$(uname -n)"
    fi

    hosts=(
        "${localname}"
        "$_ssh_config_hosts[@]"
        "$_ssh_hosts[@]"
        "$_etc_hosts[@]"
        localhost
    )
    zstyle ':completion:*:hosts' hosts $hosts
    # TODO: so, why is this here?
    #  zstyle '*' hosts $hosts

    # use generic completion system for programs not yet defined; (_gnu_generic works
    # with commands that provide a --help option with "standard" gnu-like output.)
    for compcom in cp deborphan df feh fetchipac gpasswd head hnb ipacsum mv \
                   pal stow uname ; do
        [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
    done; unset compcom

    # see upgrade function in this file
    compdef _hosts upgrade
}

# Keyboard setup: The following is based on the same code, we wrote for
# debian's setup. It ensures the terminal is in the right mode, when zle is
# active, so the values from $terminfo are valid. Therefore, this setup should
# work on all systems, that have support for `terminfo'. It also requires the
# zsh in use to have the `zsh/terminfo' module built.
#
# If you are customising your `zle-line-init()' or `zle-line-finish()'
# functions, make sure you call the following utility functions in there:
#
#     - zle-line-init():      zle-smkx
#     - zle-line-finish():    zle-rmkx

# Use emacs-like key bindings by default:
bindkey -e

# Custom widgets:

## beginning-of-line OR beginning-of-buffer OR beginning of history
## by: Bart Schaefer <schaefer@brasslantern.com>, Bernhard Tittelbach
function beginning-or-end-of-somewhere () {
    local hno=$HISTNO
    if [[ ( "${LBUFFER[-1]}" == $'\n' && "${WIDGET}" == beginning-of* ) || \
      ( "${RBUFFER[1]}" == $'\n' && "${WIDGET}" == end-of* ) ]]; then
        zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
    else
        zle .${WIDGET:s/somewhere/line-hist/} "$@"
        if (( HISTNO != hno )); then
            zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
        fi
    fi
}
zle -N beginning-of-somewhere beginning-or-end-of-somewhere
zle -N end-of-somewhere beginning-or-end-of-somewhere

# add a command line to the shells history without executing it
function commit-to-history () {
    print -rs ${(z)BUFFER}
    zle send-break
}
zle -N commit-to-history

# only slash should be considered as a word separator:
function slash-backward-kill-word () {
    local WORDCHARS="${WORDCHARS:s@/@}"
    # zle backward-word
    zle backward-kill-word
}
zle -N slash-backward-kill-word

# a generic accept-line wrapper

# This widget can prevent unwanted autocorrections from command-name
# to _command-name, rehash automatically on enter and call any number
# of builtin and user-defined widgets in different contexts.
#
# For a broader description, see:
# <http://bewatermyfriend.org/posts/2007/12-26.11-50-38-tooltime.html>
#
# The code is imported from the file 'zsh/functions/accept-line' from
# <http://ft.bewatermyfriend.org/comp/zsh/zsh-dotfiles.tar.bz2>, which
# distributed under the same terms as zsh itself.

# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true

function Accept-Line () {
    setopt localoptions noksharrays
    local -a subs
    local -xi aldone
    local sub
    local alcontext=${1:-$alcontext}

    zstyle -a ":acceptline:${alcontext}" actions subs

    (( ${#subs} < 1 )) && return 0

    (( aldone = 0 ))
    for sub in ${subs} ; do
        [[ ${sub} == 'accept-line' ]] && sub='.accept-line'
        zle ${sub}

        (( aldone > 0 )) && break
    done
}

function Accept-Line-getdefault () {
    emulate -L zsh
    local default_action

    zstyle -s ":acceptline:${alcontext}" default_action default_action
    case ${default_action} in
        ((accept-line|))
            printf ".accept-line"
            ;;
        (*)
            printf ${default_action}
            ;;
    esac
}

function Accept-Line-HandleContext () {
    zle Accept-Line

    default_action=$(Accept-Line-getdefault)
    zstyle -T ":acceptline:${alcontext}" call_default \
        && zle ${default_action}
}

function accept-line () {
    setopt localoptions noksharrays
    local -a cmdline
    local -x alcontext
    local buf com fname format msg default_action

    alcontext='default'
    buf="${BUFFER}"
    cmdline=(${(z)BUFFER})
    com="${cmdline[1]}"
    fname="_${com}"

    Accept-Line 'preprocess'

    zstyle -t ":acceptline:${alcontext}" rehash \
        && [[ -z ${commands[$com]} ]]           \
        && rehash

    if    [[ -n ${com}               ]] \
       && [[ -n ${reswords[(r)$com]} ]] \
       || [[ -n ${aliases[$com]}     ]] \
       || [[ -n ${functions[$com]}   ]] \
       || [[ -n ${builtins[$com]}    ]] \
       || [[ -n ${commands[$com]}    ]] ; then

        # there is something sensible to execute, just do it.
        alcontext='normal'
        Accept-Line-HandleContext

        return
    fi

    if    [[ -o correct              ]] \
       || [[ -o correctall           ]] \
       && [[ -n ${functions[$fname]} ]] ; then

        # nothing there to execute but there is a function called
        # _command_name; a completion widget. Makes no sense to
        # call it on the commandline, but the correct{,all} options
        # will ask for it nevertheless, so warn the user.
        if [[ ${LASTWIDGET} == 'accept-line' ]] ; then
            # Okay, we warned the user before, he called us again,
            # so have it his way.
            alcontext='force'
            Accept-Line-HandleContext

            return
        fi

        if zstyle -t ":acceptline:${alcontext}" nocompwarn ; then
            alcontext='normal'
            Accept-Line-HandleContext
        else
            # prepare warning message for the user, configurable via zstyle.
            zstyle -s ":acceptline:${alcontext}" compwarnfmt msg

            if [[ -z ${msg} ]] ; then
                msg="%c will not execute and completion %f exists."
            fi

            zformat -f msg "${msg}" "c:${com}" "f:${fname}"

            zle -M -- "${msg}"
        fi
        return
    elif [[ -n ${buf//[$' \t\n']##/} ]] ; then
        # If we are here, the commandline contains something that is not
        # executable, which is neither subject to _command_name correction
        # and is not empty. might be a variable assignment
        alcontext='misc'
        Accept-Line-HandleContext

        return
    fi

    # If we got this far, the commandline only contains whitespace, or is empty.
    alcontext='empty'
    Accept-Line-HandleContext
}

zle -N accept-line
zle -N Accept-Line
zle -N Accept-Line-HandleContext

# power completion / abbreviation expansion / buffer expansion
# see http://zshwiki.org/home/examples/zleiab for details
# less risky than the global aliases but powerful as well
# just type the abbreviation key and afterwards 'ctrl-x .' to expand it
declare -A abk
setopt extendedglob
setopt interactivecomments
abk=(
#   key   # value                  (#d additional doc string)
#A# start
    '...'  '../..'
    '....' '../../..'
    'BG'   '& exit'
    'C'    '| wc -l'
    'G'    '|& grep '${grep_options:+"${grep_options[*]}"}
    'H'    '| head'
    'Hl'   ' --help |& less -r'    #d (Display help in pager)
    'L'    '| less'
    'LL'   '|& less -r'
    'M'    '| most'
    'N'    '&>/dev/null'           #d (No Output)
    'R'    '| tr A-z N-za-m'       #d (ROT13)
    'SL'   '| sort | less'
    'S'    '| sort -u'
    'T'    '| tail'
    'V'    '|& vim -'
#A# end
    'co'   './configure && make && sudo make install'
)

function zleiab () {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}

zle -N zleiab

function help-show-abk () {
  zle -M "$(print "Available abbreviations for expansion:"; print -a -C 2 ${(kv)abk})"
}

zle -N help-show-abk

# press "ctrl-x d" to insert the actual date in the form yyyy-mm-dd
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp

# press esc-m for inserting last typed word again (thanks to caphuso!)
function insert-last-typed-word () { zle insert-last-word -- 0 -1 };
zle -N insert-last-typed-word;

function grml-zsh-fg () {
  if (( ${#jobstates} )); then
    zle .push-input
    [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
    BUFFER="${BUFFER}fg"
    zle .accept-line
  else
    zle -M 'No background jobs. Doing nothing.'
  fi
}
zle -N grml-zsh-fg

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word

#f5# Create directory under cursor or the selected area
function inplaceMkDirs () {
    # Press ctrl-xM to create the directory under the cursor or the selected area.
    # To select an area press ctrl-@ or ctrl-space and use the cursor.
    # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
    # directory does not exist yet -> press ctrl-XM and problem solved
    local PATHTOMKDIR
    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR
        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi
        # get marked area from buffer and eliminate whitespace
        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi
    [[ -z "${PATHTOMKDIR}" ]] && return 1
    PATHTOMKDIR=${~PATHTOMKDIR}
    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M " path already exists, doing nothing"
    else
        zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
        zle end-of-line
    fi
}

zle -N inplaceMkDirs

#v1# set number of lines to display per page
HELP_LINES_PER_PAGE=20
#v1# set location of help-zle cache file
HELP_ZLE_CACHE_FILE=~/.cache/zsh_help_zle_lines.zsh
# helper function for help-zle, actually generates the help text
function help_zle_parse_keybindings () {
    emulate -L zsh
    setopt extendedglob
    unsetopt ksharrays  #indexing starts at 1

    #v1# choose files that help-zle will parse for keybindings
    ((${+HELPZLE_KEYBINDING_FILES})) || HELPZLE_KEYBINDING_FILES=( /etc/zsh/zshrc ~/.zshrc.pre ~/.zshrc ~/.zshrc.local )

    if [[ -r $HELP_ZLE_CACHE_FILE ]]; then
        local load_cache=0
        local f
        for f ($HELPZLE_KEYBINDING_FILES) [[ $f -nt $HELP_ZLE_CACHE_FILE ]] && load_cache=1
        [[ $load_cache -eq 0 ]] && . $HELP_ZLE_CACHE_FILE && return
    fi

    #fill with default keybindings, possibly to be overwritten in a file later
    #Note that due to zsh inconsistency on escaping assoc array keys, we encase the key in '' which we will remove later
    local -A help_zle_keybindings
    help_zle_keybindings['<Ctrl>@']="set MARK"
    help_zle_keybindings['<Ctrl>x<Ctrl>j']="vi-join lines"
    help_zle_keybindings['<Ctrl>x<Ctrl>b']="jump to matching brace"
    help_zle_keybindings['<Ctrl>x<Ctrl>u']="undo"
    help_zle_keybindings['<Ctrl>_']="undo"
    help_zle_keybindings['<Ctrl>x<Ctrl>f<c>']="find <c> in cmdline"
    help_zle_keybindings['<Ctrl>a']="goto beginning of line"
    help_zle_keybindings['<Ctrl>e']="goto end of line"
    help_zle_keybindings['<Ctrl>t']="transpose charaters"
    help_zle_keybindings['<Alt>t']="transpose words"
    help_zle_keybindings['<Alt>s']="spellcheck word"
    help_zle_keybindings['<Ctrl>k']="backward kill buffer"
    help_zle_keybindings['<Ctrl>u']="forward kill buffer"
    help_zle_keybindings['<Ctrl>y']="insert previously killed word/string"
    help_zle_keybindings["<Alt>'"]="quote line"
    help_zle_keybindings['<Alt>"']="quote from mark to cursor"
    help_zle_keybindings['<Alt><arg>']="repeat next cmd/char <arg> times (<Alt>-<Alt>1<Alt>0a -> -10 times 'a')"
    help_zle_keybindings['<Alt>u']="make next word Uppercase"
    help_zle_keybindings['<Alt>l']="make next word lowercase"
    help_zle_keybindings['<Ctrl>xG']="preview expansion under cursor"
    help_zle_keybindings['<Alt>q']="push current CL into background, freeing it. Restore on next CL"
    help_zle_keybindings['<Alt>.']="insert (and interate through) last word from prev CLs"
    help_zle_keybindings['<Alt>,']="complete word from newer history (consecutive hits)"
    help_zle_keybindings['<Alt>m']="repeat last typed word on current CL"
    help_zle_keybindings['<Ctrl>v']="insert next keypress symbol literally (e.g. for bindkey)"
    help_zle_keybindings['!!:n*<Tab>']="insert last n arguments of last command"
    help_zle_keybindings['!!:n-<Tab>']="insert arguments n..N-2 of last command (e.g. mv s s d)"
    help_zle_keybindings['<Alt>h']="show help/manpage for current command"

    #init global variables
    unset help_zle_lines help_zle_sln
    typeset -g -a help_zle_lines
    typeset -g help_zle_sln=1

    local k v f cline
    local lastkeybind_desc contents     #last description starting with #k# that we found
    local num_lines_elapsed=0            #number of lines between last description and keybinding
    #search config files in the order they a called (and thus the order in which they overwrite keybindings)
    for f in $HELPZLE_KEYBINDING_FILES; do
        [[ -r "$f" ]] || continue   #not readable ? skip it
        contents="$(<$f)"
        for cline in "${(f)contents}"; do
            #zsh pattern: matches lines like: #k# ..............
            if [[ "$cline" == (#s)[[:space:]]#\#k\#[[:space:]]##(#b)(*)[[:space:]]#(#e) ]]; then
                lastkeybind_desc="$match[*]"
                num_lines_elapsed=0
            #zsh pattern: matches lines that set a keybinding using bind2map, bindkey or compdef -k
            #             ignores lines that are commentend out
            #             grabs first in '' or "" enclosed string with length between 1 and 6 characters
            elif [[ "$cline" == [^#]#(bind2maps[[:space:]](*)-s|bindkey|compdef -k)[[:space:]](*)(#b)(\"((?)(#c1,6))\"|\'((?)(#c1,6))\')(#B)(*)  ]]; then
                #description previously found ? description not more than 2 lines away ? keybinding not empty ?
                if [[ -n $lastkeybind_desc && $num_lines_elapsed -lt 2 && -n $match[1] ]]; then
                    #substitute keybinding string with something readable
                    k=${${${${${${${match[1]/\\e\^h/<Alt><BS>}/\\e\^\?/<Alt><BS>}/\\e\[5~/<PageUp>}/\\e\[6~/<PageDown>}//(\\e|\^\[)/<Alt>}//\^/<Ctrl>}/3~/<Alt><Del>}
                    #put keybinding in assoc array, possibly overwriting defaults or stuff found in earlier files
                    #Note that we are extracting the keybinding-string including the quotes (see Note at beginning)
                    help_zle_keybindings[${k}]=$lastkeybind_desc
                fi
                lastkeybind_desc=""
            else
              ((num_lines_elapsed++))
            fi
        done
    done
    unset contents
    #calculate length of keybinding column
    local kstrlen=0
    for k (${(k)help_zle_keybindings[@]}) ((kstrlen < ${#k})) && kstrlen=${#k}
    #convert the assoc array into preformated lines, which we are able to sort
    for k v in ${(kv)help_zle_keybindings[@]}; do
        #pad keybinding-string to kstrlen chars and remove outermost characters (i.e. the quotes)
        help_zle_lines+=("${(r:kstrlen:)k[2,-2]}${v}")
    done
    #sort lines alphabetically
    help_zle_lines=("${(i)help_zle_lines[@]}")
    [[ -d ${HELP_ZLE_CACHE_FILE:h} ]] || mkdir -p "${HELP_ZLE_CACHE_FILE:h}"
    echo "help_zle_lines=(${(q)help_zle_lines[@]})" >| $HELP_ZLE_CACHE_FILE
    zcompile $HELP_ZLE_CACHE_FILE
}
typeset -g help_zle_sln
typeset -g -a help_zle_lines

# Provides (partially autogenerated) help on keybindings and the zsh line editor
function help-zle () {
    emulate -L zsh
    unsetopt ksharrays  #indexing starts at 1
    #help lines already generated ? no ? then do it
    [[ ${+functions[help_zle_parse_keybindings]} -eq 1 ]] && {help_zle_parse_keybindings && unfunction help_zle_parse_keybindings}
    #already displayed all lines ? go back to the start
    [[ $help_zle_sln -gt ${#help_zle_lines} ]] && help_zle_sln=1
    local sln=$help_zle_sln
    #note that help_zle_sln is a global var, meaning we remember the last page we viewed
    help_zle_sln=$((help_zle_sln + HELP_LINES_PER_PAGE))
    zle -M "${(F)help_zle_lines[sln,help_zle_sln-1]}"
}
zle -N help-zle

## complete word from currently visible Screen or Tmux buffer.
if check_com -c screen || check_com -c tmux; then
    function _complete_screen_display () {
        [[ "$TERM" != "screen" ]] && return 1

        local TMPFILE=$(mktemp)
        local -U -a _screen_display_wordlist
        trap "rm -f $TMPFILE" EXIT

        # fill array with contents from screen hardcopy
        if ((${+TMUX})); then
            #works, but crashes tmux below version 1.4
            #luckily tmux -V option to ask for version, was also added in 1.4
            tmux -V &>/dev/null || return
            tmux -q capture-pane \; save-buffer -b 0 $TMPFILE \; delete-buffer -b 0
        else
            screen -X hardcopy $TMPFILE
            # screen sucks, it dumps in latin1, apparently always. so recode it
            # to system charset
            check_com recode && recode latin1 $TMPFILE
        fi
        _screen_display_wordlist=( ${(QQ)$(<$TMPFILE)} )
        # remove PREFIX to be completed from that array
        _screen_display_wordlist[${_screen_display_wordlist[(i)$PREFIX]}]=""
        compadd -a _screen_display_wordlist
    }
    #m# k CTRL-x\,\,\,S Complete word from GNU screen buffer
    bindkey -r "^xS"
    compdef -k _complete_screen_display complete-word '^xS'
fi

# Load a few more functions and tie them to widgets, so they can be bound:

function zrcautozle () {
    emulate -L zsh
    local fnc=$1
    zrcautoload $fnc && zle -N $fnc
}

function zrcgotwidget () {
    (( ${+widgets[$1]} ))
}

function zrcgotkeymap () {
    [[ -n ${(M)keymaps:#$1} ]]
}

zrcautozle insert-files
zrcautozle edit-command-line
zrcautozle insert-unicode-char
if zrcautoload history-search-end; then
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end  history-search-end
fi
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history

# The actual terminal setup hooks and bindkey-calls:

# An array to note missing features to ease diagnosis in case of problems.
typeset -ga grml_missing_features

function zrcbindkey () {
    if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
        bindkey "$@"
    fi
}

function bind2maps () {
    local i sequence widget
    local -a maps

    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    if [[ "$1" == "-s" ]]; then
        shift
        sequence="$1"
    else
        sequence="${key[$1]}"
    fi
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        zrcbindkey -M "$i" "$sequence" "$widget"
    done
}

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-smkx () {
        emulate -L zsh
        printf '%s' ${terminfo[smkx]}
    }
    function zle-rmkx () {
        emulate -L zsh
        printf '%s' ${terminfo[rmkx]}
    }
    function zle-line-init () {
        zle-smkx
    }
    function zle-line-finish () {
        zle-rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
else
    for i in {s,r}mkx; do
        (( ${+terminfo[$i]} )) || grml_missing_features+=($i)
    done
    unset i
fi

typeset -A key
key=(
    Home     "${terminfo[khome]}"
    End      "${terminfo[kend]}"
    Insert   "${terminfo[kich1]}"
    Delete   "${terminfo[kdch1]}"
    Up       "${terminfo[kcuu1]}"
    Down     "${terminfo[kcud1]}"
    Left     "${terminfo[kcub1]}"
    Right    "${terminfo[kcuf1]}"
    PageUp   "${terminfo[kpp]}"
    PageDown "${terminfo[knp]}"
    BackTab  "${terminfo[kcbt]}"
)

# Guidelines for adding key bindings:
#
#   - Do not add hardcoded escape sequences, to enable non standard key
#     combinations such as Ctrl-Meta-Left-Cursor. They are not easily portable.
#
#   - Adding Ctrl characters, such as '^b' is okay; note that '^b' and '^B' are
#     the same key.
#
#   - All keys from the $key[] mapping are obviously okay.
#
#   - Most terminals send "ESC x" when Meta-x is pressed. Thus, sequences like
#     '\ex' are allowed in here as well.

bind2maps emacs             -- Home   beginning-of-somewhere
bind2maps       viins vicmd -- Home   vi-beginning-of-line
bind2maps emacs             -- End    end-of-somewhere
bind2maps       viins vicmd -- End    vi-end-of-line
bind2maps emacs viins       -- Insert overwrite-mode
bind2maps             vicmd -- Insert vi-insert
bind2maps emacs             -- Delete delete-char
bind2maps       viins vicmd -- Delete vi-delete-char
bind2maps emacs viins vicmd -- Up     up-line-or-search
bind2maps emacs viins vicmd -- Down   down-line-or-search
bind2maps emacs             -- Left   backward-char
bind2maps       viins vicmd -- Left   vi-backward-char
bind2maps emacs             -- Right  forward-char
bind2maps       viins vicmd -- Right  vi-forward-char
#k# Perform abbreviation expansion
bind2maps emacs viins       -- -s '^x.' zleiab
#k# Display list of abbreviations that would expand
bind2maps emacs viins       -- -s '^xb' help-show-abk
#k# mkdir -p <dir> from string under cursor or marked area
bind2maps emacs viins       -- -s '^xM' inplaceMkDirs
#k# display help for keybindings and ZLE
bind2maps emacs viins       -- -s '^xz' help-zle
#k# Insert files and test globbing
bind2maps emacs viins       -- -s "^xf" insert-files
#k# Edit the current line in \kbd{\$EDITOR}
bind2maps emacs viins       -- -s '\ee' edit-command-line
#k# search history backward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xp' history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xP' history-beginning-search-forward-end
#k# search history backward for entry beginning with typed text
bind2maps emacs viins       -- PageUp history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bind2maps emacs viins       -- PageDown history-beginning-search-forward-end
bind2maps emacs viins       -- -s "^x^h" commit-to-history
#k# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\ev' slash-backward-kill-word
#k# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\e^h' slash-backward-kill-word
#k# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\e^?' slash-backward-kill-word
# Do history expansion on space:
bind2maps emacs viins       -- -s ' ' magic-space
#k# Trigger menu-complete
bind2maps emacs viins       -- -s '\ei' menu-complete  # menu completion via esc-i
#k# Insert a timestamp on the command line (yyyy-mm-dd)
bind2maps emacs viins       -- -s '^xd' insert-datestamp
#k# Insert last typed word
bind2maps emacs viins       -- -s "\em" insert-last-typed-word
#k# A smart shortcut for \kbd{fg<enter>}
bind2maps emacs viins       -- -s '^z' grml-zsh-fg
#k# prepend the current command with "sudo"
bind2maps emacs viins       -- -s "^os" sudo-command-line
#k# jump to after first word (for adding options)
bind2maps emacs viins       -- -s '^x1' jump_after_first_word
#k# complete word from history with menu
bind2maps emacs viins       -- -s "^x^x" hist-complete

# insert unicode character
# usage example: 'ctrl-x i' 00A7 'ctrl-x i' will give you an §
# See for example http://unicode.org/charts/ for unicode characters code
#k# Insert Unicode character
bind2maps emacs viins       -- -s '^xi' insert-unicode-char

# use the new *-pattern-* widgets for incremental history search
if zrcgotwidget history-incremental-pattern-search-backward; then
    for seq wid in '^r' history-incremental-pattern-search-backward \
                   '^s' history-incremental-pattern-search-forward
    do
        bind2maps emacs viins vicmd -- -s $seq $wid
    done
    builtin unset -v seq wid
fi

if zrcgotkeymap menuselect; then
    #m# k Shift-tab Perform backwards menu completion
    bind2maps menuselect -- BackTab reverse-menu-complete

    #k# menu selection: pick item but stay in the menu
    bind2maps menuselect -- -s '\e^M' accept-and-menu-complete
    # also use + and INSERT since it's easier to press repeatedly
    bind2maps menuselect -- -s '+' accept-and-menu-complete
    bind2maps menuselect -- Insert accept-and-menu-complete

    # accept a completion and try to complete again by using menu
    # completion; very useful with completing directories
    # by using 'undo' one's got a simple file browser
    bind2maps menuselect -- -s '^o' accept-and-infer-next-history
fi

# Finally, here are still a few hardcoded escape sequences; Special sequences
# like Ctrl-<Cursor-key> etc do suck a fair bit, because they are not
# standardised and most of the time are not available in a terminals terminfo
# entry.
#
# While we do not encourage adding bindings like these, we will keep these for
# backward compatibility.

## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on
## the command line.
# URxvt sequences:
bind2maps emacs viins vicmd -- -s '\eOc' forward-word
bind2maps emacs viins vicmd -- -s '\eOd' backward-word
# These are for xterm:
bind2maps emacs viins vicmd -- -s '\e[1;5C' forward-word
bind2maps emacs viins vicmd -- -s '\e[1;5D' backward-word
## the same for alt-left-arrow and alt-right-arrow
# URxvt again:
bind2maps emacs viins vicmd -- -s '\e\e[C' forward-word
bind2maps emacs viins vicmd -- -s '\e\e[D' backward-word
# Xterm again:
bind2maps emacs viins vicmd -- -s '^[[1;3C' forward-word
bind2maps emacs viins vicmd -- -s '^[[1;3D' backward-word
# Also try ESC Left/Right:
bind2maps emacs viins vicmd -- -s '\e'${key[Right]} forward-word
bind2maps emacs viins vicmd -- -s '\e'${key[Left]}  backward-word

# autoloading

zrcautoload zmv
zrcautoload zed




# we don't want to quote/espace URLs on our own...
# if autoload -U url-quote-magic ; then
#    zle -N self-insert url-quote-magic
#    zstyle ':url-quote-magic:*' url-metas '*?[]^()~#{}='
# else
#    print 'Notice: no url-quote-magic available :('
# fi
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'

#m# k ESC-h Call \kbd{run-help} for the 1st word on the command line
alias run-help >&/dev/null && unalias run-help
for rh in run-help{,-ip,-openssl,-p4,-sudo,-svk,-svn}; do
    zrcautoload $rh
done; unset rh

# history

#v#
HISTFILE=${HISTFILE:-${ZDOTDIR:-${HOME}}/.zsh_history}

# dirstack handling

DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${DIRSTACKFILE:-${ZDOTDIR:-${HOME}}/.zdirs}

if zstyle -T ':grml:chpwd:dirstack' enable; then
    typeset -gaU GRML_PERSISTENT_DIRSTACK
    function grml_dirstack_filter () {
        local -a exclude
        local filter entry
        if zstyle -s ':grml:chpwd:dirstack' filter filter; then
            $filter $1 && return 0
        fi
        if zstyle -a ':grml:chpwd:dirstack' exclude exclude; then
            for entry in "${exclude[@]}"; do
                [[ $1 == ${~entry} ]] && return 0
            done
        fi
        return 1
    }

    function chpwd () {
        (( ZSH_SUBSHELL )) && return
        (( $DIRSTACKSIZE <= 0 )) && return
        [[ -z $DIRSTACKFILE ]] && return
        grml_dirstack_filter $PWD && return
        GRML_PERSISTENT_DIRSTACK=(
            $PWD "${(@)GRML_PERSISTENT_DIRSTACK[1,$DIRSTACKSIZE]}"
        )
        builtin print -l ${GRML_PERSISTENT_DIRSTACK} >! ${DIRSTACKFILE}
    }

    if [[ -f ${DIRSTACKFILE} ]]; then
        # Enabling NULL_GLOB via (N) weeds out any non-existing
        # directories from the saved dir-stack file.
        dirstack=( ${(f)"$(< $DIRSTACKFILE)"}(N) )
        # "cd -" won't work after login by just setting $OLDPWD, so
        [[ -d $dirstack[1] ]] && cd -q $dirstack[1] && cd -q $OLDPWD
    fi

    if zstyle -t ':grml:chpwd:dirstack' filter-on-load; then
        for i in "${dirstack[@]}"; do
            if ! grml_dirstack_filter "$i"; then
                GRML_PERSISTENT_DIRSTACK=(
                    "${GRML_PERSISTENT_DIRSTACK[@]}"
                    $i
                )
            fi
        done
    else
        GRML_PERSISTENT_DIRSTACK=( "${dirstack[@]}" )
    fi
fi

# directory based profiles

# Prompt setup for grml:

# set colors for use in prompts (modern zshs allow for the use of %F{red}foo%f
# in prompts to get a red "foo" embedded, but it's good to keep these for
# backwards compatibility).
    BLUE="%F{blue}"
    RED="%F{red}"
    GREEN="%F{green}"
    CYAN="%F{cyan}"
    MAGENTA="%F{magenta}"
    YELLOW="%F{yellow}"
    WHITE="%F{white}"
    NO_COLOR="%f"

# First, the easy ones: PS2..4:

# secondary prompt, printed when the shell needs more information to complete a
# command.
PS2='\`%_> '
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i>'
PS4='+%N:%i:%_> '

# Some additional features to use with our prompt:
#
#    - battery status
#    - debian_chroot
#    - vcs_info setup and version specific fixes

# display battery status on right side of prompt using 'GRML_DISPLAY_BATTERY=1' in .zshrc.pre

function battery () {
if [[ $GRML_DISPLAY_BATTERY -gt 0 ]] ; then
        batterylinux
fi
}

function batterylinux () {
GRML_BATTERY_LEVEL=''
local batteries bat capacity
batteries=( /sys/class/power_supply/BAT*(N) )
if (( $#batteries > 0 )) ; then
    for bat in $batteries ; do
        if [[ -e $bat/capacity ]]; then
            capacity=$(< $bat/capacity)
        else
            typeset -F energy_full=$(< $bat/energy_full)
            typeset -F energy_now=$(< $bat/energy_now)
            typeset -i capacity=$(( 100 * $energy_now / $energy_full))
        fi
        case $(< $bat/status) in
        Charging)
            GRML_BATTERY_LEVEL+=" ^"
            ;;
        Discharging)
            if (( capacity < 20 )) ; then
                GRML_BATTERY_LEVEL+=" !v"
            else
                GRML_BATTERY_LEVEL+=" v"
            fi
            ;;
        *) # Full, Unknown
            GRML_BATTERY_LEVEL+=" ="
            ;;
        esac
        GRML_BATTERY_LEVEL+="${capacity}%%"
    done
fi
}

function batteryopenbsd () {
GRML_BATTERY_LEVEL=''
local bat batfull batwarn batnow num
for num in 0 1 ; do
    bat=$(sysctl -n hw.sensors.acpibat${num} 2>/dev/null)
    if [[ -n $bat ]]; then
        batfull=${"$(sysctl -n hw.sensors.acpibat${num}.amphour0)"%% *}
        batwarn=${"$(sysctl -n hw.sensors.acpibat${num}.amphour1)"%% *}
        batnow=${"$(sysctl -n hw.sensors.acpibat${num}.amphour3)"%% *}
        case "$(sysctl -n hw.sensors.acpibat${num}.raw0)" in
            *" discharging"*)
                if (( batnow < batwarn )) ; then
                    GRML_BATTERY_LEVEL+=" !v"
                else
                    GRML_BATTERY_LEVEL+=" v"
                fi
                ;;
            *" charging"*)
                GRML_BATTERY_LEVEL+=" ^"
                ;;
            *)
                GRML_BATTERY_LEVEL+=" ="
                ;;
        esac
        GRML_BATTERY_LEVEL+="${$(( 100 * batnow / batfull ))%%.*}%%"
    fi
done
}

function batteryfreebsd () {
GRML_BATTERY_LEVEL=''
local num
local -A table
for num in 0 1 ; do
    table=( ${=${${${${${(M)${(f)"$(acpiconf -i $num 2>&1)"}:#(State|Remaining capacity):*}%%( ##|%)}//:[ $'\t']##/@}// /-}//@/ }} )
    if [[ -n $table ]] && [[ $table[State] != "not-present" ]] ; then
        case $table[State] in
            *discharging*)
                if (( $table[Remaining-capacity] < 20 )) ; then
                    GRML_BATTERY_LEVEL+=" !v"
                else
                    GRML_BATTERY_LEVEL+=" v"
                fi
                ;;
            *charging*)
                GRML_BATTERY_LEVEL+=" ^"
                ;;
            *)
                GRML_BATTERY_LEVEL+=" ="
                ;;
        esac
        GRML_BATTERY_LEVEL+="$table[Remaining-capacity]%%"
    fi
done
}

function batterydarwin () {
GRML_BATTERY_LEVEL=''
local -a table
table=( ${$(pmset -g ps)[(w)8,9]%%(\%|);} )
if [[ -n $table[2] ]] ; then
    case $table[2] in
        charging)
            GRML_BATTERY_LEVEL+=" ^"
            ;;
        discharging)
            if (( $table[1] < 20 )) ; then
                GRML_BATTERY_LEVEL+=" !v"
            else
                GRML_BATTERY_LEVEL+=" v"
            fi
            ;;
        *)
            GRML_BATTERY_LEVEL+=" ="
            ;;
    esac
    GRML_BATTERY_LEVEL+="$table[1]%%"
fi
}

# set variable debian_chroot if running in a chroot with /etc/debian_chroot
if [[ -z "$debian_chroot" ]] && [[ -r /etc/debian_chroot ]] ; then
    debian_chroot=$(</etc/debian_chroot)
fi

# gather version control information for inclusion in a prompt

if zrcautoload vcs_info; then
    # `vcs_info' in zsh versions 4.3.10 and below have a broken `_realpath'
    # function, which can cause a lot of trouble with our directory-based
    # profiles. So:
    if [[ ${ZSH_VERSION} == 4.3.<-10> ]] ; then
        function VCS_INFO_realpath () {
            setopt localoptions NO_shwordsplit chaselinks
            ( builtin cd -q $1 2> /dev/null && pwd; )
        }
    fi

    zstyle ':vcs_info:*' max-exports 2

    if [[ -o restricted ]]; then
        zstyle ':vcs_info:*' enable NONE
    fi
fi

typeset -A grml_vcs_coloured_formats
typeset -A grml_vcs_plain_formats

grml_vcs_plain_formats=(
    format "(%s%)-[%b] "    "zsh: %r"
    actionformat "(%s%)-[%b|%a] " "zsh: %r"
    rev-branchformat "%b:%r"
)

grml_vcs_coloured_formats=(
    format "${MAGENTA}(${NO_COLOR}%s${MAGENTA})${YELLOW}-${MAGENTA}[${GREEN}%b${MAGENTA}]${NO_COLOR} "
    actionformat "${MAGENTA}(${NO_COLOR}%s${MAGENTA})${YELLOW}-${MAGENTA}[${GREEN}%b${YELLOW}|${RED}%a${MAGENTA}]${NO_COLOR} "
    rev-branchformat "%b${RED}:${YELLOW}%r"
)
# Change vcs_info formats for the grml prompt. The 2nd format sets up
# $vcs_info_msg_1_ to contain "zsh: repo-name" used to set our screen title.


function grml_prompt_setup () {
    emulate -L zsh
    autoload -Uz vcs_info
    # The following autoload is disabled for now, since this setup includes a
    # static version of the ‘add-zsh-hook’ function above. It needs to be
    # re-enabled as soon as that static definition is removed again.
    #autoload -Uz add-zsh-hook
    add-zsh-hook precmd prompt_$1_precmd
}

function prompt_grml_setup () {
    grml_prompt_setup grml
}

function prompt_grml-chroot_setup () {
    grml_prompt_setup grml-chroot
}

function prompt_grml-large_setup () {
    grml_prompt_setup grml-large
}



# Now for the fun part: The grml prompt themes in `promptsys' mode of operation

# This actually defines three prompts:
#
#    - grml
#    - grml-large
#    - grml-chroot
#
# They all share the same code and only differ with respect to which items they
# contain. The main source of documentation is the `prompt_grml_help' function
# below, which gets called when the user does this: prompt -h grml
# These maps define default tokens and pre-/post-decoration for items to be
# used within the themes. All defaults may be customised in a context sensitive
# matter by using zsh's `zstyle' mechanism.
typeset -gA grml_prompt_pre_default \
            grml_prompt_post_default \
            grml_prompt_token_default \
            grml_prompt_token_function

grml_prompt_pre_default=(
    at                ''
    battery           ' '
    change-root       ''
    date              '%F{blue}'
    grml-chroot       '%F{red}'
    history           '%F{green}'
    host              '%F{blue}'
    jobs              '%F{cyan}'
    newline           ''
    path              '%B'
    percent           ''
    rc                '%B%F{red}'
    rc-always         ''
    sad-smiley        ''
    shell-level       '%F{red}'
    time              '%F{blue}'
    user              '%B%F{green}'
    vcs               ''
)

grml_prompt_post_default=(
    at                ''
    battery           ''
    change-root       ''
    date              '%f'
    grml-chroot       '%f '
    history           '%f'
    host              '%f'
    jobs              '%f'
    newline           ''
    path              '%b'
    percent           ''
    rc                '%f%b'
    rc-always         ''
    sad-smiley        ''
    shell-level       '%f'
    time              '%f'
    user              '%f%b'
    vcs               ''
)

grml_prompt_token_default=(
    at                '@'
    battery           'GRML_BATTERY_LEVEL'
    change-root       'debian_chroot'
    date              '%D{%Y-%m-%d}'
    grml-chroot       'GRML_CHROOT'
    history           '{history#%!} '
    host              '%m '
    jobs              '[%j running job(s)] '
    newline           $'\n'
    path              '%40<..<%~%<< '
    percent           '$ '
    rc                '%(?..%? )'
    rc-always         '%?'
    sad-smiley        '%(?..:()'
    shell-level       '%(3L.+ .)'
    time              '%D{%H:%M:%S} '
    user              '%n'
    vcs               '0'
)

function grml_theme_has_token () {
    if (( ARGC != 1 )); then
        printf 'usage: grml_theme_has_token <name>\n'
        return 1
    fi
    (( ${+grml_prompt_token_default[$1]} ))
}

function GRML_theme_add_token_usage () {
    <<__EOF0__
  Usage: grml_theme_add_token <name> [-f|-i] <token/function> [<pre> <post>]

    <name> is the name for the newly added token. If the \`-f' or \`-i' options
    are used, <token/function> is the name of the function (see below for
    details). Otherwise it is the literal token string to be used. <pre> and
    <post> are optional.

  Options:

    -f <function>   Use a function named \`<function>' each time the token
                    is to be expanded.

    -i <function>   Use a function named \`<function>' to initialise the
                    value of the token _once_ at runtime.

    The functions are called with one argument: the token's new name. The
    return value is expected in the \$REPLY parameter. The use of these
    options is mutually exclusive.

    There is a utility function \`grml_theme_has_token', which you can use
    to test if a token exists before trying to add it. This can be a guard
    for situations in which a \`grml_theme_add_token' call may happen more
    than once.

  Example:

    To add a new token \`day' that expands to the current weekday in the
    current locale in green foreground colour, use this:

      grml_theme_add_token day '%D{%A}' '%F{green}' '%f'

    Another example would be support for \$VIRTUAL_ENV:

      function virtual_env_prompt () {
        REPLY=\${VIRTUAL_ENV+\${VIRTUAL_ENV:t} }
      }
      grml_theme_add_token virtual-env -f virtual_env_prompt

    After that, you will be able to use a changed \`items' style to
    assemble your prompt.
__EOF0__
}

function grml_theme_add_token () {
    emulate -L zsh
    local name token pre post
    local -i init funcall

    if (( ARGC == 0 )); then
        GRML_theme_add_token_usage
        return 0
    fi

    init=0
    funcall=0
    pre=''
    post=''
    name=$1
    shift
    if [[ $1 == '-f' ]]; then
        funcall=1
        shift
    elif [[ $1 == '-i' ]]; then
        init=1
        shift
    fi

    if (( ARGC == 0 )); then
        printf '
grml_theme_add_token: No token-string/function-name provided!\n\n'
        GRML_theme_add_token_usage
        return 1
    fi
    token=$1
    shift
    if (( ARGC != 0 && ARGC != 2 )); then
        printf '
grml_theme_add_token: <pre> and <post> need to by specified _both_!\n\n'
        GRML_theme_add_token_usage
        return 1
    fi
    if (( ARGC )); then
        pre=$1
        post=$2
        shift 2
    fi

    if grml_theme_has_token $name; then
        printf '
grml_theme_add_token: Token `%s'\'' exists! Giving up!\n\n' $name
        GRML_theme_add_token_usage
        return 2
    fi
    if (( init )); then
        REPLY=''
        $token $name
        token=$REPLY
    fi
    grml_prompt_pre_default[$name]=$pre
    grml_prompt_post_default[$name]=$post
    if (( funcall )); then
        grml_prompt_token_function[$name]=$token
        grml_prompt_token_default[$name]=23
    else
        grml_prompt_token_default[$name]=$token
    fi
}

function grml_wrap_reply () {
    emulate -L zsh
    local target="$1"
    local new="$2"
    local left="$3"
    local right="$4"

    if (( ${+parameters[$new]} )); then
        REPLY="${left}${(P)new}${right}"
    else
        REPLY=''
    fi
}

function grml_prompt_addto () {
    emulate -L zsh
    local target="$1"
    local lr it apre apost new v REPLY
    local -a items
    shift

    [[ $target == PS1 ]] && lr=left || lr=right
    zstyle -a ":prompt:${grmltheme}:${lr}:setup" items items || items=( "$@" )
    typeset -g "${target}="
    for it in "${items[@]}"; do
        zstyle -s ":prompt:${grmltheme}:${lr}:items:$it" pre apre \
            || apre=${grml_prompt_pre_default[$it]}
        zstyle -s ":prompt:${grmltheme}:${lr}:items:$it" post apost \
            || apost=${grml_prompt_post_default[$it]}
        zstyle -s ":prompt:${grmltheme}:${lr}:items:$it" token new \
            || new=${grml_prompt_token_default[$it]}
        if (( ${+grml_prompt_token_function[$it]} )); then
            REPLY=''
            ${grml_prompt_token_function[$it]} $it
        else
            case $it in
            battery)
                grml_wrap_reply $target $new '' ''
                ;;
            change-root)
                grml_wrap_reply $target $new '(' ')'
                ;;
            grml-chroot)
                if [[ -n ${(P)new} ]]; then
                    REPLY="$CHROOT"
                else
                    REPLY=''
                fi
                ;;
            vcs)
                v="vcs_info_msg_${new}_"
                if (( ! vcscalled )); then
                    vcs_info
                    vcscalled=1
                fi
                if (( ${+parameters[$v]} )) && [[ -n "${(P)v}" ]]; then
                    REPLY="${(P)v}"
                else
                    REPLY=''
                fi
                ;;
            *) REPLY="$new" ;;
            esac
        fi
        # Strip volatile characters per item. This is off by default. See the
        # global stripping code a few lines below for details.
        if [[ -o prompt_subst ]] && zstyle -t ":prompt:${grmltheme}:${lr}:items:$it" \
                                           strip-sensitive-characters
        then
            REPLY="${REPLY//[$\`]/}"
        fi
        typeset -g "${target}=${(P)target}${apre}${REPLY}${apost}"
    done

    # Per default, strip volatile characters (in the prompt_subst case)
    # globally. If the option is off, the style has no effect. For more
    # control, this can be turned off and stripping can be configured on a
    # per-item basis (see above).
    if [[ -o prompt_subst ]] && zstyle -T ":prompt:${grmltheme}:${lr}:setup" \
                                       strip-sensitive-characters
    then
        typeset -g "${target}=${${(P)target}//[$\`]/}"
    fi
}

function prompt_grml_precmd () {
    emulate -L zsh
    local grmltheme=grml
    local -a left_items right_items
    left_items=(rc change-root user at host path percent)
    right_items=(sad-smiley)

    prompt_grml_precmd_worker
}

function prompt_grml-chroot_precmd () {
    emulate -L zsh
    local grmltheme=grml-chroot
    local -a left_items right_items
    left_items=(grml-chroot user at host path percent)
    right_items=()

    prompt_grml_precmd_worker
}

function prompt_grml-large_precmd () {
    emulate -L zsh
    local grmltheme=grml-large
    local -a left_items right_items
    left_items=(rc jobs history shell-level change-root time date newline
                user at host path percent)
    right_items=(sad-smiley)

    prompt_grml_precmd_worker
}

function prompt_grml_precmd_worker () {
    emulate -L zsh
    local -i vcscalled=0

    grml_prompt_addto PS1 "${left_items[@]}"
    if zstyle -T ":prompt:${grmltheme}:right:setup" use-rprompt; then
        grml_prompt_addto RPS1 "${right_items[@]}"
    fi
}

function grml_prompt_fallback () {
    setopt prompt_subst
    local p0 p1

    p0="${RED}%(?..%? )${WHITE}${debian_chroot:+($debian_chroot)}"
    p1="${GREEN}%n${NO_COLOR}@%m %40<...<%B%~%b%<< "'${vcs_info_msg_0_}'"%# "
    if (( EUID == 0 )); then
        PROMPT="${BLUE}${p0}${RED}${p1}"
    else
        PROMPT="${RED}${p0}${BLUE}${p1}"
    fi
}

if zrcautoload promptinit && promptinit 2>/dev/null ; then
    # Since we define the required functions in here and not in files in
    # $fpath, we need to stick the theme's name into `$prompt_themes'
    # ourselves, since promptinit does not pick them up otherwise.
    prompt_themes+=( grml grml-chroot grml-large )
    # Also, keep the array sorted...
    prompt_themes=( "${(@on)prompt_themes}" )
else
    print 'Notice: no promptinit available :('
    grml_prompt_fallback
    function precmd () { (( ${+functions[vcs_info]} )) && vcs_info; }
fi

    # The prompt themes use modern features of zsh, that require at least
    # version 4.3.7 of the shell. Use the fallback otherwise.
    if [[ $GRML_DISPLAY_BATTERY -gt 0 ]]; then
        zstyle ':prompt:grml:right:setup' items sad-smiley battery
        add-zsh-hook precmd battery
    fi
    if [[ "$TERM" == dumb ]] ; then
        zstyle ":prompt:grml(|-large|-chroot):*:items:grml-chroot" pre ''
        zstyle ":prompt:grml(|-large|-chroot):*:items:grml-chroot" post ' '
        for i in rc user path jobs history date time shell-level; do
            zstyle ":prompt:grml(|-large|-chroot):*:items:$i" pre ''
            zstyle ":prompt:grml(|-large|-chroot):*:items:$i" post ''
        done
        unset i
        zstyle ':prompt:grml(|-large|-chroot):right:setup' use-rprompt false
    elif (( EUID == 0 )); then
        zstyle ':prompt:grml(|-large|-chroot):*:items:user' pre '%B%F{red}'
    fi

    # Finally enable one of the prompts.
    if [[ -n $GRML_CHROOT ]]; then
        prompt grml-chroot
    elif [[ $GRMLPROMPT -gt 0 ]]; then
        prompt grml-large
    else
        prompt grml
    fi
    if [[ "$TERM" == dumb ]] ; then
        prompt redhat
    fi

# Terminal-title wizardry

function ESC_print () {
    info_print $'\ek' $'\e\\' "$@"
}
function set_title () {
    info_print  $'\e]0;' $'\a' "$@"
}

function info_print () {
    local esc_begin esc_end
    esc_begin="$1"
    esc_end="$2"
    shift 2
    printf '%s' ${esc_begin}
    printf '%s' "$*"
    printf '%s' "${esc_end}"
}

function grml_reset_screen_title () {
    # adjust title of xterm
    # see http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
    [[ ${NOTITLE:-} -gt 0 ]] && return 0
    case $TERM in
        (xterm*|rxvt*)
            set_title ${(%):-"%n@%m: %~"}
            ;;
    esac
}

function grml_vcs_to_screen_title () {
    if [[ $TERM == screen* ]] ; then
        if [[ -n ${vcs_info_msg_1_} ]] ; then
            ESC_print ${vcs_info_msg_1_}
        else
            ESC_print "zsh"
        fi
    fi
}

function grml_maintain_name () {
    local localname
    localname="$(uname -n)"

    # set hostname if not running on local machine
    if [[ -n "$HOSTNAME" ]] && [[ "$HOSTNAME" != "${localname}" ]] ; then
       NAME="@$HOSTNAME"
    fi
}

function grml_cmd_to_screen_title () {
    # get the name of the program currently running and hostname of local
    # machine set screen window title if running in a screen
    if [[ "$TERM" == screen* ]] ; then
        local CMD="${1[(wr)^(*=*|sudo|ssh|-*)]}$NAME"
        ESC_print ${CMD}
    fi
}

function grml_control_xterm_title () {
    case $TERM in
        (xterm*|rxvt*)
            set_title "${(%):-"%n@%m:"}" "$2"
            ;;
    esac
}
# do we have GNU ls with color-support?
if [[ "$TERM" != dumb ]]; then
    #a1# List files with colors (\kbd{ls \ldots})
    alias ls="command ls ${ls_options:+${ls_options[*]}}"
    #a1# List all files, with colors (\kbd{ls -la \ldots})
    alias la="command ls -la ${ls_options:+${ls_options[*]}}"
    #lh hooman
    alias lh="command ls -lah ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, without dotfiles (\kbd{ls -l \ldots})
    alias ll="command ls -l ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, human readable sizes (\kbd{ls -hAl \ldots})
    alias lh="command ls -hAl ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, append qualifier to filenames (\kbd{ls -l \ldots})\\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
    alias l="command ls -l ${ls_options:+${ls_options[*]}}"
else
    alias la='command ls -la'
    alias ll='command ls -l'
    alias lh='command ls -hAl'
    alias l='command ls -l'
fi

if [[ -r /proc/mdstat ]]; then
    alias mdstat='cat /proc/mdstat'
fi

alias ...='cd ../../'

# generate alias named "$KERNELVERSION-reboot" so you can use boot with kexec:
if [[ -x /sbin/kexec ]] && [[ -r /proc/cmdline ]] ; then
    alias "$(uname -r)-reboot"="kexec -l --initrd=/boot/initrd.img-"$(uname -r)" --command-line=\"$(cat /proc/cmdline)\" /boot/vmlinuz-"$(uname -r)""
fi

# see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term for details
alias term2iso="echo 'Setting terminal to iso mode' ; print -n '\e%@'"
alias term2utf="echo 'Setting terminal to utf-8 mode'; print -n '\e%G'"

# make sure it is not assigned yet
[[ -n ${aliases[utf2iso]} ]] && unalias utf2iso
function utf2iso () {
    if isutfenv ; then
        local ENV
        for ENV in $(env | command grep -i '.utf') ; do
            eval export "$(echo $ENV | sed 's/UTF-8/iso885915/ ; s/utf8/iso885915/')"
        done
    fi
}

# make sure it is not assigned yet
[[ -n ${aliases[iso2utf]} ]] && unalias iso2utf
function iso2utf () {
    if ! isutfenv ; then
        local ENV
        for ENV in $(env | command grep -i '\.iso') ; do
            eval export "$(echo $ENV | sed 's/iso.*/UTF-8/ ; s/ISO.*/UTF-8/')"
        done
    fi
}

# especially for roadwarriors using GNU screen and ssh:
if ! check_com asc &>/dev/null ; then
  function asc () { autossh -t "$@" 'screen -RdU' }
  compdef asc=ssh
fi


# use /var/log/syslog iff present, fallback to journalctl otherwise
if [ -e /var/log/syslog ] ; then
  #a1# Take a look at the syslog: \kbd{\$PAGER /var/log/syslog || journalctl}
  salias llog="$PAGER /var/log/syslog"     # take a look at the syslog
  #a1# Take a look at the syslog: \kbd{tail -f /var/log/syslog || journalctl}
  salias tlog="tail -f /var/log/syslog"    # follow the syslog
elif check_com -c journalctl ; then
  salias llog="journalctl"
  salias tlog="journalctl -f"
fi
# wonderful idea of using "e" glob qualifier by Peter Stephenson
# You use it as follows:
# $ NTREF=/reference/file
# $ ls -l *(e:nt:)
# This lists all the files in the current directory newer than the reference file.
# You can also specify the reference file inline; note quotes:
# $ ls -l *(e:'nt ~/.zshenv':)
function nt () {
    if [[ -n $1 ]] ; then
        local NTREF=${~1}
    fi
    [[ $REPLY -nt $NTREF ]]
}

# shell functions


#f1# Provides useful information on globbing
function H-Glob () {
    echo -e "
    /      directories
    .      plain files
    @      symbolic links
    =      sockets
    p      named pipes (FIFOs)
    *      executable plain files (0100)
    %      device files (character or block special)
    %b     block special files
    %c     character special files
    r      owner-readable files (0400)
    w      owner-writable files (0200)
    x      owner-executable files (0100)
    A      group-readable files (0040)
    I      group-writable files (0020)
    E      group-executable files (0010)
    R      world-readable files (0004)
    W      world-writable files (0002)
    X      world-executable files (0001)
    s      setuid files (04000)
    S      setgid files (02000)
    t      files with the sticky bit (01000)

  print *(m-1)          # Files modified up to a day ago
  print *(a1)           # Files accessed a day ago
  print *(@)            # Just symlinks
  print *(Lk+50)        # Files bigger than 50 kilobytes
  print *(Lk-50)        # Files smaller than 50 kilobytes
  print **/*.c          # All *.c files recursively starting in \$PWD
  print **/*.c~file.c   # Same as above, but excluding 'file.c'
  print (foo|bar).*     # Files starting with 'foo' or 'bar'
  print *~*.*           # All Files that do not contain a dot
  chmod 644 *(.^x)      # make all plain non-executable files publically readable
  print -l *(.c|.h)     # Lists *.c and *.h
  print **/*(g:users:)  # Recursively match all files that are owned by group 'users'
  echo /proc/*/cwd(:h:t:s/self//) # Analogous to >ps ax | awk '{print $1}'<"
}
alias help-zshglob=H-Glob

# grep for running process, like: 'any vim'
function any () {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any <keyword>" >&2 ; return 1
    else
        ps xauwww | grep -i "${grep_options[@]}" "[${1[1]}]${1[2,-1]}"
    fi
}



# a wrapper for vim, that deals with title setting
#   VIM_OPTIONS
#       set this array to a set of options to vim you always want
#       to have set when calling vim (in .zshrc.local), like:
#           VIM_OPTIONS=( -p )
#       This will cause vim to send every file given on the
#       commandline to be send to it's own tab (needs vim7).
if check_com vim; then
    function vim () {
        VIM_PLEASE_SET_TITLE='yes' command vim ${VIM_OPTIONS} "$@"
    }
fi

# make sure our environment is clean regarding colors
builtin unset -v BLUE RED GREEN CYAN YELLOW MAGENTA WHITE NO_COLOR

# "persistent history"
# just write important commands you always need to $GRML_IMPORTANT_COMMANDS
# defaults for backward compatibility to ~/.important_commands
if [[ -r ~/.important_commands ]] ; then
    GRML_IMPORTANT_COMMANDS=~/.important_commands
else
    GRML_IMPORTANT_COMMANDS=${GRML_IMPORTANT_COMMANDS:-${ZDOTDIR:-${HOME}}/.important_commands}
fi
[[ -r ${GRML_IMPORTANT_COMMANDS} ]] && builtin fc -R ${GRML_IMPORTANT_COMMANDS}

# load the lookup subsystem if it's available on the system
zrcautoload lookupinit && lookupinit

# variables

# set terminal property (used e.g. by msgid-chooser)
export COLORTERM="yes"

# aliases


# general
#a2# Execute \kbd{du -sch}
# some useful aliases
#a2# Remove current empty directory. Execute \kbd{cd ..; rmdir \$OLDCWD}

# useful functions

#f5# Backup \kbd{file_or_folder {\rm to} file_or_folder\_timestamp}
function bk () {
    emulate -L zsh
    local current_date=$(date -u "+%Y%m%dT%H%M%SZ")
    local clean keep move verbose result all to_bk
    setopt extended_glob
    keep=1
    while getopts ":hacmrv" opt; do
        case $opt in
            a) (( all++ ));;
            c) unset move clean && (( ++keep ));;
            m) unset keep clean && (( ++move ));;
            r) unset move keep && (( ++clean ));;
            v) verbose="-v";;
            h) <<__EOF0__
bk [-hcmv] FILE [FILE ...]
bk -r [-av] [FILE [FILE ...]]
Backup a file or folder in place and append the timestamp
Remove backups of a file or folder, or all backups in the current directory

Usage:
-h    Display this help text
-c    Keep the file/folder as is, create a copy backup using cp(1) (default)
-m    Move the file/folder, using mv(1)
-r    Remove backups of the specified file or directory, using rm(1). If none
      is provided, remove all backups in the current directory.
-a    Remove all (even hidden) backups.
-v    Verbose

The -c, -r and -m options are mutually exclusive. If specified at the same time,
the last one is used.

The return code is the sum of all cp/mv/rm return codes.
__EOF0__
return 0;;
            \?) bk -h >&2; return 1;;
        esac
    done
    shift "$((OPTIND-1))"
    if (( keep > 0 )); then
        if islinux ; then
            for to_bk in "$@"; do
                cp $verbose -a "${to_bk%/}" "${to_bk%/}_$current_date"
                (( result += $? ))
            done
        else
            for to_bk in "$@"; do
                cp $verbose -pR "${to_bk%/}" "${to_bk%/}_$current_date"
                (( result += $? ))
            done
        fi
    elif (( move > 0 )); then
        while (( $# > 0 )); do
            mv $verbose "${1%/}" "${1%/}_$current_date"
            (( result += $? ))
            shift
        done
    elif (( clean > 0 )); then
        if (( $# > 0 )); then
            for to_bk in "$@"; do
                rm $verbose -rf "${to_bk%/}"_[0-9](#c8)T([0-1][0-9]|2[0-3])([0-5][0-9])(#c2)Z
                (( result += $? ))
            done
        else
            if (( all > 0 )); then
                rm $verbose -rf *_[0-9](#c8)T([0-1][0-9]|2[0-3])([0-5][0-9])(#c2)Z(D)
            else
                rm $verbose -rf *_[0-9](#c8)T([0-1][0-9]|2[0-3])([0-5][0-9])(#c2)Z
            fi
            (( result += $? ))
        fi
    fi
    return $result
}

#f5# cd to directory and list files
function cl () {
    emulate -L zsh
    cd $1 && ls -a
}

# smart cd function, allows switching to /etc when running 'cd /etc/fstab'
function cd () {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

#f5# Create Directory and \kbd{cd} to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

#f5# Create temporary directory and \kbd{cd} to it
function cdt () {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

#f5# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

#f5# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}

#f5# List files which have been modified within the last {\it n} days, {\it n} defaults to 1
function modified () {
    emulate -L zsh
    print -l -- *(m-${1:-1})
}
# modified() was named new() in earlier versions, add an alias for backwards compatibility
check_com new || alias new=modified

# use colors when GNU grep with color-support
if (( $#grep_options > 0 )); then
    o=${grep_options:+"${grep_options[*]}"}
    #a2# Execute \kbd{grep -{}-color=auto}
    alias grep='grep '$o
    alias egrep='egrep '$o
    unset o
fi


# Usage: simple-extract <file>
# Using option -d deletes the original archive file.
#f5# Smart archive extractor
function simple-extract () {
    emulate -L zsh
    setopt extended_glob noclobber
    local ARCHIVE DELETE_ORIGINAL DECOMP_CMD USES_STDIN USES_STDOUT GZTARGET WGET_CMD
    local RC=0
    zparseopts -D -E "d=DELETE_ORIGINAL"
    for ARCHIVE in "${@}"; do
        case $ARCHIVE in
            *(tar.bz2|tbz2|tbz))
                DECOMP_CMD="tar -xvjf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *(tar.gz|tgz))
                DECOMP_CMD="tar -xvzf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *(tar.xz|txz|tar.lzma))
                DECOMP_CMD="tar -xvJf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *tar.zst)
                DECOMP_CMD="tar --zstd -xvf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *tar)
                DECOMP_CMD="tar -xvf -"
                USES_STDIN=true
                USES_STDOUT=false
                ;;
            *rar)
                DECOMP_CMD="unrar x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *lzh)
                DECOMP_CMD="lha x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *7z)
                DECOMP_CMD="7z x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *(zip|jar))
                DECOMP_CMD="unzip"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *deb)
                DECOMP_CMD="ar -x"
                USES_STDIN=false
                USES_STDOUT=false
                ;;
            *bz2)
                DECOMP_CMD="bzip2 -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *(gz|Z))
                DECOMP_CMD="gzip -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *(xz|lzma))
                DECOMP_CMD="xz -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *zst)
                DECOMP_CMD="zstd -d -c -"
                USES_STDIN=true
                USES_STDOUT=true
                ;;
            *)
                print "ERROR: '$ARCHIVE' has unrecognized archive type." >&2
                RC=$((RC+1))
                continue
                ;;
        esac

        if ! check_com ${DECOMP_CMD[(w)1]}; then
            echo "ERROR: ${DECOMP_CMD[(w)1]} not installed." >&2
            RC=$((RC+2))
            continue
        fi

        GZTARGET="${ARCHIVE:t:r}"
        if [[ -f $ARCHIVE ]] ; then

            print "Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} < "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} < "$ARCHIVE"
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} "$ARCHIVE"
                fi
            fi
            [[ $? -eq 0 && -n "$DELETE_ORIGINAL" ]] && rm -f "$ARCHIVE"

        elif [[ "$ARCHIVE" == (#s)(https|http|ftp)://* ]] ; then
            if check_com curl; then
                WGET_CMD="curl -L -s -o -"
            elif check_com wget; then
                WGET_CMD="wget -q -O -"
            elif check_com fetch; then
                WGET_CMD="fetch -q -o -"
            else
                print "ERROR: neither wget, curl nor fetch is installed" >&2
                RC=$((RC+4))
                continue
            fi
            print "Downloading and Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD} > $GZTARGET
                    RC=$((RC+$?))
                else
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD}
                    RC=$((RC+$?))
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE") > $GZTARGET
                else
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE")
                fi
            fi

        else
            print "ERROR: '$ARCHIVE' is neither a valid file nor a supported URI." >&2
            RC=$((RC+8))
        fi
    done
    return $RC
}

function __archive_or_uri () {
    _alternative \
        'files:Archives:_files -g "*.(#l)(tar.bz2|tbz2|tbz|tar.gz|tgz|tar.xz|txz|tar.lzma|tar|rar|lzh|7z|zip|jar|deb|bz2|gz|Z|xz|lzma)"' \
        '_urls:Remote Archives:_urls'
}

function _simple_extract () {
    _arguments \
        '-d[delete original archivefile after extraction]' \
        '*:Archive Or Uri:__archive_or_uri'
}
compdef _simple_extract simple-extract
[[ -n "$GRML_NO_SMALL_ALIASES" ]] || alias se=simple-extract

#f5# Change the xterm title from within GNU-screen
function xtrename () {
    emulate -L zsh
    if [[ $1 != "-f" ]] ; then
        if [[ -z ${DISPLAY} ]] ; then
            printf 'xtrename only makes sense in X11.\n'
            return 1
        fi
    else
        shift
    fi
    if [[ -z $1 ]] ; then
        printf 'usage: xtrename [-f] "title for xterm"\n'
        printf '  renames the title of xterm from _within_ screen.\n'
        printf '  also works without screen.\n'
        printf '  will not work if DISPLAY is unset, use -f to override.\n'
        return 0
    fi
    print -n "\eP\e]0;${1}\C-G\e\\"
    return 0
}



zpst () { curl -F'file=@-' https://0x0.st }

# upload to ttm
function zup () {
    emulate -L zsh
    setopt extended_glob

    if [[ -z $1 ]]; then
        print "USAGE: zup <FILE>"
        return 1
    fi

    local PN url prog api json contenttype item
    local -a data
    PN=$0
    url=$1


    if check_com -c curl; then
        prog=curl
    else
        print "curl is not available, but mandatory for ${PN}. Aborting."
        return 1
    fi
    api='https://0x0.st/'
    curl -F"file=@${url}" $api   
}

# bypass them nasty blocks
function zpost () {
    emulate -L zsh
    setopt extended_glob

    if [[ -z $1 ]]; then
        print "USAGE: zpost <URL>"
        return 1
    fi

    local PN url prog api json contenttype item
    local -a data
    PN=$0
    url=$1

    # Prepend 'http://' to given URL where necessary for later output.
    if [[ ${url} != http(s|)://* ]]; then
        url='https://'${url}
    fi

    if check_com -c curl; then
        prog=curl
    else
        print "curl is not available, but mandatory for ${PN}. Aborting."
        return 1
    fi
    api='https://0x0.st/'
    curl -F"url=${url}" $api   
}




# ttmsh > goo.gl
function zurl () {
    emulate -L zsh
    setopt extended_glob

    if [[ -z $1 ]]; then
        print "USAGE: zurl <URL>"
        return 1
    fi

    local PN url prog api json contenttype item
    local -a data
    PN=$0
    url=$1

    # Prepend 'http://' to given URL where necessary for later output.
    if [[ ${url} != http(s|)://* ]]; then
        url='https://'${url}
    fi

    if check_com -c curl; then
        prog=curl
    else
        print "curl is not available, but mandatory for ${PN}. Aborting."
        return 1
    fi
    api='https://0x0.st/'
    curl -F"shorten=${url}" $api   
}

#f2# Find history events by search pattern and list them by date.
function whatwhen () {
    emulate -L zsh
    local usage help ident format_l format_s first_char remain first last
    usage='USAGE: whatwhen [options] <searchstring> <search range>'
    help='Use `whatwhen -h'\'' for further explanations.'
    ident=${(l,${#${:-Usage: }},, ,)}
    format_l="${ident}%s\t\t\t%s\n"
    format_s="${format_l//(\\t)##/\\t}"
    # Make the first char of the word to search for case
    # insensitive; e.g. [aA]
    first_char=[${(L)1[1]}${(U)1[1]}]
    remain=${1[2,-1]}
    # Default search range is `-100'.
    first=${2:-\-100}
    # Optional, just used for `<first> <last>' given.
    last=$3
    case $1 in
        ("")
            printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (-h)
            printf '%s\n\n' ${usage}
            print 'OPTIONS:'
            printf $format_l '-h' 'show help text'
            print '\f'
            print 'SEARCH RANGE:'
            printf $format_l "'0'" 'the whole history,'
            printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
            printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
            printf '\n%s\n' 'EXAMPLES:'
            printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -100 by default.'
            printf $format_l 'whatwhen zsh -250'
            printf $format_l 'whatwhen foo 1 99'
        ;;
        (\?)
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (*)
            # -l list results on stout rather than invoking $EDITOR.
            # -i Print dates as in YYYY-MM-DD.
            # -m Search for a - quoted - pattern within the history.
            fc -li -m "*${first_char}${remain}*" $first $last
        ;;
    esac
}

# disable bracketed paste mode for dumb terminals
[[ "$TERM" == dumb ]] && unset zle_bracketed_paste


PATH=$PATH:$HOME/.local/bin
alias t="topydo"
alias sysu='systemctl --user'
alias mkdir='mkdir -p'

source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions.zsh



zrclocal

## genrefcard.pl settings

### doc strings for external functions from files
#m# f5 grml-wallpaper() Sets a wallpaper (try completion for possible values)

### example: split functions-search 8,16,24,32
#@# split functions-search 8

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
# Local variables:
# mode: sh
# End:

