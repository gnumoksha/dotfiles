# $ZDOTDIR/.zshrc: user-wide .zshrc file for zsh(1).
#
# This file is sourced only for interactive shells. It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Global Order: zshenv, zprofile, zshrc, zlogin


#|
#| Profiling
#|
#zmodload zsh/zprof
#/usr/bin/time zsh -i -c exit
STARTED_AT=$(date +%s.%N)


#|
#| My custom scripts
#|
# May start tmux.
source "$XDG_CONFIG_HOME/tmux/utils.sh"
# Settings related to the terminal prompt and ls colors.
# Contains prezto settings that need to be defined before prezto is loaded.
source "$ZDOTDIR/theme.zsh"


#|
#| Plugins
#|
# Plugins with zplug
#source $XDG_CONFIG_HOME/zsh/zplug.zsh

# Plugins with zgen
#source $XDG_CONFIG_HOME/zsh/zgen.zsh

# Plugins with oh-my-zsh
source $XDG_CONFIG_HOME/zsh/oh-my-zsh/oh-my-zsh.zsh


#|
#| ZSH settings
#|
# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000


#|
#| Load my custom bourne shell plugins.
#| It is here to ensure plugins will not override my configurations.
#|
source "$DOTFILES_SHELL_PLUGINS/bootstrap.sh"

LOAD_TIME=$(( $(date +%s.%N) - STARTED_AT ))
if [[ $LOAD_TIME -gt 1 ]]; then
    >&2 echo "[warning] startup time was $LOAD_TIME seconds."
fi
unset STARTED_AT LOAD_TIME


#|
#| References
#|
# man

# vim: ft=zsh
