# $ZDOTDIR/.zshrc: user-wide .zshrc file for zsh(1).
#
# This file is sourced only for interactive shells. It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

#
# Profiling
#
#zmodload zsh/zprof
#/usr/bin/time zsh -i -c exit
STARTED_AT=$(date +%s.%N)

#
# Tmux
#
source "$XDG_CONFIG_HOME/tmux/utils.sh"

#
# Zplug
#
# If you need to uninstall zplug, do:
# rm -Rf $ZPLUG_HOME $ZPLUG_CACHE_DIR $ZPLUG_BIN
ZPLUG_HOME="$XDG_DATA_HOME/zplug"
ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/zplug.plugins.zsh"
ZPLUG_BIN='/usr/local/bin/zplug'
ZPLUG_USE_CACHE=true
ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"
if [[ ! -e "$ZPLUG_HOME/init.zsh" ]]; then
	echo "Installing zplug..."
	if [[ ! -d "$ZPLUG_HOME" ]]; then
		mkdir -p "$ZPLUG_HOME"
	fi
	curl --silent --show-error --location --proto-redir -all,https \
		https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	# in order to wait something that will make zplug available.
	sleep 3s
	ZPLUG_WAS_JUST_INSTALLED=true
fi
source "$ZPLUG_HOME/init.zsh"
zplug load

#
# Zgen
#
# PoC with zgen.
#source "${HOME}/.zgen/zgen.zsh"
#if ! zgen saved; then
	#source $XDG_CONFIG_HOME/zsh/zgen.plugins.sh
#fi

# Screen-related stuff.
source "$ZDOTDIR/themes/config.zsh"
# Load my custom shell-agnostic stuff.
source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

#
# ZSH settings
#
# History file configuration
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
#setopt append_history           # Do not overwrite history
#setopt extended_history         # Also record time and duration of commands.
#setopt share_history            # Share history between multiple shells
#setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Do not display duplicates during searches.
#setopt hist_ignore_dups         # Ignore consecutive duplicates.
#setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
#setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt prompt_subst             # Make sure prompt is able to be generated properly.
# from oh-my-zsh
#alwaystoend
#autocd
#autopushd
#completeinword
#extendedhistory
#noflowcontrol
#histexpiredupsfirst
#histfindnodups
#histignorealldups
#histignoredups
#histignorespace
#histreduceblanks
#histsavenodups
#histverify
#incappendhistory
#interactive
#interactivecomments
#login
#longlistjobs
#monitor
#promptsubst
#pushdignoredups
#pushdminus
#sharehistory
#shinstdin
#zle

LOAD_TIME=$(( $(date +%s.%N) - STARTED_AT ))
if [[ $LOAD_TIME -gt 1 ]]; then
	>&2 echo "[warning] startup time was $LOAD_TIME seconds."
fi
unset STARTED_AT LOAD_TIME

# See:
# https://github.com/tonylambiris/dotfiles/blob/master/dot.zshrc

# Prompt
#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

# http://grml.org/zsh/zsh-lovers.html
# http://www.bash2zsh.com/zsh_refcard/refcard.pdf

# vim: ft=zsh
