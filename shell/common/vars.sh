#!/usr/bin/env sh

export TERM="xterm-256color"

export MY_BIN_DIR="/usr/local/bin"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

