# Utils functions from tmux.
# No shebang is specified because this functions ca be executed in bash or zsh.

# https://github.com/tmux/tmux/issues/142 :(
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

if [[ ! -z "$TMUX" ]]; then
	function installTmuxPluginManager {
	  if [[ ! -e "$XDG_CONFIG_HOME"/tmux/plugins/tpm ]]; then
	    echo "Installing Tmux Plugin Manager (TPM)..."
	    git clone --depth=1 https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
	  fi
	}

	installTmuxPluginManager
fi

