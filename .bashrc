# ~/.bashrc by Hans Lambermont
# vim:ts=4:sw=4
#
# There are 3 different types of shells in bash: the login shell, normal
# shell and interactive shell. Login shells read ~/.profile and
# interactive shells read ~/.bashrc; On many systems /etc/profile
# sources ~/.bashrc - thus all settings made here will also take effect
# in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather
# than here, since multilingual X sessions would not work properly if
# LANG is overridden in every subshell.

PATH=$HOME/bin:/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin:/home/matt/PhpStorm/bin:/home/matt/pycharm-2.6.2/bin
export PATH

umask 002

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000
HISTTIMEFORMAT="%Y%m%d_%H%M%S "

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
    xterm*|screen)
		color_prompt=yes
	;;
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
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
    # http://www.novell.com/coolsolutions/trench/15086.html
    # for i in `seq 30 37`;do echo -e "\e[1;${i}mtest\e[0m$i ";done
#    PROMPT_COMMAND='test $PRETVAL -eq $? && RETVAL=0 || RETVAL=$?'
	PS1error='$( ret=$?; test $ret -gt 0 && echo "\[\e[41;93m\]\\$?=$ret\[\e[0m\] " )'
	PS1user="$( test $USER == root && echo '\[\e[101m\]\u\[\e[0m\]' || echo '\[\e[1;32m\]\u\[\e[0m\]')"
	PS1term="$( ( test $TERM == screen && echo '\[\e[1;101m\]\h\[\e[0m\]' ) || \
        ( test -n "$SSH_TTY" && echo '\[\e[1;31m\]\h\[\e[0m\]' ) || \
        echo '\[\e[1;30m\]\h\[\e[0m\]')"
    PS1chroot="${chroot_name:+($chroot_name)}"
    PS1="\D{%Y%m%d_%H%M%S} $PS1user@$PS1term:$PS1chroot\[\e[1;34m\]\w\[\e[0m\]/ $PS1error"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
alias l='ls -la --color=auto'
alias ll='ls -l --color=auto'
[ -x $HOME/bin/allfilter ] && alias allf='tail -F /var/log/syslog | allfilter'
alias quo="du -kx | grep -v '[a-zA-Z0-9]/' | sort -n"
[ -x $HOME/bin/vimman ] && alias man='man -P ~/bin/vimman'
alias hosts="grep ^Host ~/.ssh/config| grep -v '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'"
alias diff='diff --exclude=.svn'
[ -x /usr/bin/colordiff ] && alias diff="colordiff --exclude=.svn $@"
alias grep='grep --exclude-dir=".svn" --exclude-dir="build"'
alias fgrep='fgrep --exclude-dir=".svn" --exclude-dir="build"'

export EDITOR=vim
export MORE=less
export GREP_OPTIONS='--color=auto'
#export LESS='-r'

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

# Finally source local settings, also used to override things.
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

set -o vi
JENKINS_HOME=/var/lib/jenkins/workspace
eval `ssh-agent`
ssh-add
