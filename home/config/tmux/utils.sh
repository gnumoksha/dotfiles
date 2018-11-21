# Utils functions for working with tmux.

# Only execute this script if tmux is installed.
command -v tmux >/dev/null 2>&1 || return

# Tmux does not support a custom variable to point to the tmux.conf :(
# https://github.com/tmux/tmux/issues/142
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

TMUX_SESSION_NAME=${TMUX_SESSION_NAME:=TMUX}

# Wheter or not the shell is running inside TMUX.
if [[ ! -z "$TMUX" ]]; then
	# Shell is running inside tmux.
	if [[ ! -e "$XDG_CONFIG_HOME"/tmux/plugins/tpm ]]; then
		echo "Installing Tmux Plugin Manager (TPM) since it is not installed."
		git clone --depth=1 https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
	fi
else
	tmux attach -t $TMUX_SESSION_NAME || tmux new -s $TMUX_SESSION_NAME
	exit; # Automatically close the terminal when tmux exits.
fi

