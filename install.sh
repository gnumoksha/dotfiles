#!/usr/bin/env bash

STOW="$(which stow) --verbose=0"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

source install-shell.sh
source install-gui.sh

echo "Finished."

