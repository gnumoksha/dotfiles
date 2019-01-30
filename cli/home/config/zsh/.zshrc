#################################
#                               #
#             zshrc             #
#                               #
#################################

source "$XDG_CONFIG_HOME/tmux/utils.sh"

# Profiling
#zmodload zsh/zprof
#/usr/bin/time zsh -i -c exit
startedAt=$(date +%s.%N)

# ZSH settings {{{
## History file configuration
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
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
#}}}

# ZPLUG
if [ ! -e "$ZPLUG_HOME/init.zsh" ]; then
	if [ ! -d "$ZPLUG_HOME" ]; then
		mkdir -p "$ZPLUG_HOME"
	fi
	curl --silent --show-error --location --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	# in order to wait something that will make zplug available.
	sleep 3s
	ZPLUG_WAS_JUST_INSTALLED=true
fi

source "$ZPLUG_HOME/init.zsh"
# I was unable to use zplug source
source "$ZDOTDIR/themes/config.zsh"

zplug load

# This will load my custom shell-agnostic settings.
# Is here to guarantee that zplug plugins will not override
# the behavior defined by this script.
# zplug "$DOTFILES_SHELL_PLUGINS/", from:local
source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

finishedAt=`date +%s.%N`
loadTime=$((finishedAt-startedAt))
if [[ $loadTime -gt 1 ]]; then
	echo "zsh was loaded in $loadTime seconds."
fi

# See:
# https://github.com/tonylambiris/dotfiles/blob/master/dot.zshrc

# Prompt
#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

# http://grml.org/zsh/zsh-lovers.html
# http://www.bash2zsh.com/zsh_refcard/refcard.pdf

# vim: ft=zsh