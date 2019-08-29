#!/usr/bin/env bash
# shellcheck disable=SC2128
if [[ -z "$XDG_CONFIG_HOME" ]]; then
	>&2 echo "XDG_CONFIG_HOME is not defined! Plugins will not be loaded!"
	exit 1
fi

if [[ ! -z "$BASH_SOURCE" ]]; then
	DOTFILES_SCRIPT_DIR=$(dirname "$BASH_SOURCE")
else
	DOTFILES_SCRIPT_DIR=$(dirname "$0")
fi

# shellcheck source=./cli/shell/plugins/settings.sh
source "$DOTFILES_SCRIPT_DIR/settings.sh"
# shellcheck source=./cli/shell/plugins/aliases_functions.sh
source "$DOTFILES_SCRIPT_DIR/aliases_functions.sh"
# shellcheck source=./cli/shell/plugins/colors.sh
source "$DOTFILES_SCRIPT_DIR/colors.sh"
# shellcheck source=./cli/shell/plugins/containers.sh
source "$DOTFILES_SCRIPT_DIR/containers.sh"
# shellcheck source=./cli/shell/plugins/fzf.sh
source "$DOTFILES_SCRIPT_DIR/fzf.sh"

# dot not to this for the root user
if [[ $(id -u) != 0 ]]; then
    # shellcheck source=./cli/shell/plugins/ssh_gpg.sh
	source "$DOTFILES_SCRIPT_DIR/ssh_gpg.sh"
	# shellcheck source=./cli/shell/plugins/jupyter.sh
	source "$DOTFILES_SCRIPT_DIR/jupyter.sh"
fi

unset DOTFILES_SCRIPT_DIR

#EOF
