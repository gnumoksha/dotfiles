#!/usr/bin/env bash

STOW="$(which stow) --verbose=0"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

source shell-install.sh
source gui-install.sh

echo "Finished."

