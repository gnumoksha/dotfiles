#
# ~/.bashrc: executed by bash(1) for non-login (interactive) shells.
#
# Interactive shell are the ones you connected to a terminal
# (or pseudo-terminal in the case of, say, a terminal emulator
# running under a windowing system.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Minimal required variables.
#export XDG_DATA_HOME=${XDG_DATA_HOME:=${HOME}/.local/share}
export DOTFILES=${DOTFILES:=${HOME}/.dotfiles}
source "$DOTFILES/cli/shell/plugins/env.sh"

source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

#
# History
#
HISTSIZE=5000
HISTFILESIZE=10000
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Store history on XDG-based directory
# See https://wiki.archlinux.org/index.php/XDG_Base_Directory#Hardcoded
[[ ! -d "$XDG_DATA_HOME/bash"  ]] && mkdir "$XDG_DATA_HOME/bash"
export HISTFILE="$XDG_DATA_HOME"/bash/history
# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [[ "${DOTFILES_USE_COLORS}" != 'true' ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
else
	declare -A COLORS=(
		["brown"]="\[\033[00;33m\]"
		["black"]="\[\033[00;30m\]"
		["white"]="\[\033[01;37m\]"
		["yellow"]="\[\033[01;33m\]"
		["light_green"]="\[\033[01;32m\]"
		["light_blue"]="\[\033[01;34m\]"		
		["light_purple"]="\[\033[01;35m\]"
		["yellow_red"]="\[\033[01;33;41m\]"
		["underline"]="\[\033[00;4m\]"
		["none"]="\[\033[00m\]"
	)
	PS1='${debian_chroot:+($debian_chroot)}'
	if [[ $EUID -eq 0 ]]; then # root
		export PS1="${PS1}${COLORS['brown']}\t ${COLORS['yellow_red']}\u${COLORS['brown']}@${COLORS['light_green']}\h${COLORS['none']}:\w# "
	else # common user
		export PS1="${PS1}${COLORS['brown']}\t ${COLORS['light_blue']}\u${COLORS['brown']}@${COLORS['light_green']}\h${COLORS['none']}:\w\$ "
	fi
	unset COLORS
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

#EOF
