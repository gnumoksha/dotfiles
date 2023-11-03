#!/usr/bin/env bash
# Utils functions for working with tmux.

# Only execute this script if tmux is installed.
command -v tmux >/dev/null 2>&1 || return

# Tmux does not support a custom variable to point to the tmux.conf :(
# https://github.com/tmux/tmux/issues/142
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

TMUX_SESSION_NAME=${TMUX_SESSION_NAME:=TMUX}

if [[ -n "$TMUX" ]]; then
  # Shell is already running inside tmux.
  if [[ ! -e "$XDG_CACHE_HOME"/tmux/plugins/tpm ]]; then
    echo "Installing Tmux Plugin Manager (TPM) because it was not found."
    git clone \
      --depth=1 \
      --quiet \
      https://github.com/tmux-plugins/tpm \
      "$XDG_CACHE_HOME"/tmux/plugins/tpm &&
      "$XDG_CACHE_HOME"/tmux/plugins/tpm/bin/install_plugins
  fi

  return
fi

# Do not start inside Emacs, vim, vscodium.
# note: check GIO_LAUNCHED_DESKTOP_FILE to see if the main process is a GUI (didn't work on alacritty)
if [[ 
  -n "$INSIDE_EMACS" ||
  -n "$EMACS" ||
  -n "$VIM" ||
  -n "$VSCODE_RESOLVING_ENVIRONMENT" ||
  "$TERM_PROGRAM" = "vscode" ]]; then
  return
fi

# Only run tmux on the first opened terminal.
# #FIXME sometimes this command exits with 1 because it can't connect to the socket /tmp/tmux-1000/default
tmux list-sessions >/dev/null 2>&1 && return

tmux attach -t $TMUX_SESSION_NAME >/dev/null 2>&1 || tmux new -s $TMUX_SESSION_NAME
tmuxExitCode=$?
if [[ $tmuxExitCode -ne 0 ]]; then
  echo "Tmux has closed unexpectedly"
  read -p "Press [ENTER] to continue"
fi
# Automatically close the terminal when tmux exits.
exit $tmuxExitCode

# Reference
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/tmux/tmux.plugin.zsh
