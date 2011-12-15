# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
 force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -la'
alias calen='~/calendar/calendar'
alias todo='~/todo/todo'
alias truecryptu='truecrypt --fs-options="uid=1000,gid=1000,umask=0002"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PATH=~/bin:$PATH:.

FG_BLU='\[\033[1;34m\]'
FG_GRE='\[\033[1;31m\]'
FG_RED='\[\033[1;31m\]'
FG_MAG='\[\033[1;35m\]'
FG_YEL='\[\033[1;33m\]'
FG_CYA='\[\033[1;36m\]'

COLOR_RESET='\[\033[m\]'

git_prompt_info() {
	FG_BLU='\033[1;34m'
	FG_GRE='\033[1;31m'
	FG_RED='\033[1;31m'
	FG_MAG='\033[1;35m'
	FG_YEL='\033[1;33m'
	FG_CYA='\033[1;36m'
	if git branch 2>/dev/null > /dev/null
	then
		BRANCH=`git branch | grep -o '[a-zA-Z0-9_]*'`
		DIRTY=`git status |wc -l`
		if [ "$DIRTY" -gt "4" ]; then
			echo -ne " on ${FG_YEL}${BRANCH}! (dirty)"
		else
			echo -ne " on ${FG_CYA}${BRANCH} (clean)"
		fi
	else
		echo -n ""
	fi
}

prompt_char() {
	git branch > /dev/null 2> /dev/null && echo '±' && return
	hg root > /dev/null 2> /dev/null && echo '☿' && return
	case $EUID in
		0)
			echo '#' && return
			;;
		*)
			echo '$' && return
			;;
	esac
}

PS1='\n'${FG_BLU}'\u '${COLOR_RESET}'at '${FG_GRE}'\h'${COLOR_RESET}' in '${FG_MAG}'\w'${COLOR_RESET}'$(git_prompt_info)'${COLOR_RESET}
case $EUID in
	0)
		PS1=$PS1'\n'${FG_RED}'$(prompt_char) '${COLOR_RESET}
	;;
	*)
		PS1=$PS1'\n'${FG_CYA}'$(prompt_char) '${COLOR_RESET}
	;;
esac

# PS1=$PS1"\n$ "
