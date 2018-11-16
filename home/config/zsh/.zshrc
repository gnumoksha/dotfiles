#################################
#                               #
#             zshrc             #
#                               #
#################################

# Profiling
#zmodload zsh/zprof
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

# Only load plugins in interactive shells, not from a script or from scp.
if [[ $- = *i* ]]; then
	if [ ! -e "$ZPLUG_INSTALLED/init.zsh" ]; then
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	fi

	source "$ZPLUG_INSTALLED/init.zsh"
	# I was unable to use zplug source
	source "$ZDOTDIR/plugins/config.zsh"
	source "$ZDOTDIR/themes/config.zsh"

	# I was unable to use zplug source
	source "$XDG_CONFIG_HOME/tmux/utils.sh"
	source "$XDG_CONFIG_HOME/shell/common/bootstrap.sh"

	zplug load
fi

finishedAt=`date +%s.%N`
loadTime=$((finishedAt-startedAt))
if [[ $loadTime -gt 1 ]]; then
	echo "zsh was loaded in $loadTime seconds."
fi
#/usr/bin/time zsh -i -c exit

# See:
# https://github.com/tonylambiris/dotfiles/blob/master/dot.zshrc

# Prompt
#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

# http://grml.org/zsh/zsh-lovers.html
# http://www.bash2zsh.com/zsh_refcard/refcard.pdf

# vim: ft=zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
