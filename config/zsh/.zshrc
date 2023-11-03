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
# Load module zprof (man zshmodules)
# To show the results add "zprof" in the end of this file.
#zmodload zsh/zprof
# Also, you can use the following command to quickly see
# the startup time.
#time zsh -i -c exit
# The following vaiable will be used to warn the user
# if startup time is high.
STARTED_AT=$(date +%s.%N)

#|
#| Plugins and custom scripts
#|
#source $ZDOTDIR/plugins/zplug-cfg.zsh
#source $ZDOTDIR/plugins/zgen-cfg.zsh
source $ZDOTDIR/plugins/minstall.zsh
source $ZDOTDIR/plugins/minstall-cfg.zsh

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

# Prompt
# show nothing at the end of partial lines
PROMPT_EOL_MARK=''

#|
#| Load my custom shell scripts.
#| It is defined at this point to ensure other plugins will not override my
#| configurations.
#|
#FIXME tmux.sh should be started alone to not open other terminal and then load ?all plugins? again
for filename in "${DOTFILES_SHELL_PLUGINS}"/*.sh; do
  [ -f "$filename" ] || continue
  source "$filename"
done

#|
#| Profiling
#|
LOAD_TIME=$(($(date +%s.%N) - STARTED_AT))
if [[ $LOAD_TIME -gt 1 ]]; then
  echo >&2 "[warning] startup time was $LOAD_TIME seconds."
  if [[ $(zmodload | grep "^zsh/zprof$") ]]; then
    read "?Press [ENTER] to run the profiling."
    zprof # show the profilling results from zprof module, if loaded
  else
    echo >&2 "[warning] enable zsh/zprof if you want to run the profiling."
  fi
  echo >&2 '[warning] you can also run: for i in $(seq 1 10); do time /bin/zsh -i -c exit; done;'
  read "?Press [ENTER] to continue"
fi
unset STARTED_AT LOAD_TIME

#|
#| Troubleshooting
#|
# autocomplete don't work
# rm $XDG_CONFIG_HOME/zsh/.zcompdump*

# vim: ft=zsh
