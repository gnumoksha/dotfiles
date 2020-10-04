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
#| Plugins and custom scripts
#|
# Configure (but not load) oh-my-zsh
source $ZDOTDIR/plugins/oh-my-zsh/oh-my-zsh.zsh

# Install plugins
#source $ZDOTDIR/plugins/zplug.zsh
#source $ZDOTDIR/plugins/zgen.zsh
source $ZDOTDIR/plugins/simple-plugin.zsh

#|
#| ZSH settings
#|
# man 1 zshoptions
# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
# imports new commands from the history file, and also causes your typed
# commands to be appended to the history file.
unsetopt SHARE_HISTORY

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
# Remove command lines from the history list when the first character
# on the line is a space
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
# with the set-local-history zle binding
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

#|
#| Load my custom shell scripts.
#| It is here to ensure other plugins will not override my configurations.
#|
for filename in "${DOTFILES_SHELL_PLUGINS}"/*.sh; do
  [ -f "$filename" ] || continue
  source "$filename"
done


#|
#| Profiling
#|
LOAD_TIME=$(( $(date +%s.%N) - STARTED_AT ))
if [[ $LOAD_TIME -gt 1 ]]; then
    >&2 echo "[warning] startup time was $LOAD_TIME seconds."
fi
unset STARTED_AT LOAD_TIME


#|
#| Troubleshooting
#|
# autocomplete don't work
# rm $XDG_CONFIG_HOME/zsh/.zcompdump*

# vim: ft=zsh
