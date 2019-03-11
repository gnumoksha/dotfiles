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
# My custom scripts
#
# May start tmux.
source "$XDG_CONFIG_HOME/tmux/utils.sh"
# Settings related to the terminal prompt and ls colors.
# Contains prezto settings that need to be defined before prezto is loaded.
source "$ZDOTDIR/theme.zsh"

#
# Plugins
#
# 2017-10-20 - Tobias - I've checked on-my-zsh and those are the useful plugins:
# colored-man-pages composer copybuffer copydir docker docker-compose
# git git-flow-avh git-extras
# gpg-agent history-substring-search httpie nmap npm pass pip
# redis-cli rsync screen shrink-path ssh-agent systemadmin tmux
# vi-mode virtualenv
# Repository: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
#
# Plugins with zplug
#source $XDG_CONFIG_HOME/zsh/zplug.zsh
#
# Plugins with zgen
source $XDG_CONFIG_HOME/zsh/zgen.zsh

#
# ZSH settings
#
# History settings
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # Share history between multiple shells
setopt append_history         # Do not overwrite history
setopt hist_find_no_dups      # Do not display duplicates during searches.
setopt hist_reduce_blanks     # Remove superfluous blanks.
#setopt hist_ignore_all_dups # Remember only one unique copy of the command.
# Other settings
setopt prompt_subst           # Make sure prompt is able to be generated properly.
setopt no_clobber             # use >! or >>! or >| or >>|
setopt autocd                 # Allow changing directories without `cd`
setopt cdablevars
#alwaystoend
#autopushd
#completeinword
#noflowcontrol
#interactive
#interactivecomments
#login
#longlistjobs
#monitor
#promptsubst
#pushdignoredups
#pushdminus
#shinstdin
#zle

#
# Load my custom bourne shell plugins.
# It is here to ensure plugins will not override my configurations.
#
source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

LOAD_TIME=$(( $(date +%s.%N) - STARTED_AT ))
if [[ $LOAD_TIME -gt 1 ]]; then
	>&2 echo "[warning] startup time was $LOAD_TIME seconds."
fi
unset STARTED_AT LOAD_TIME

# vim: ft=zsh
