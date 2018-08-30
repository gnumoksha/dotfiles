# Utils functions from tmux.
# No shebang is specified because this functions ca be executed in bash or zsh.

function installTmuxPluginManager {
  if [[ ! -e ~/.tmux/plugins/tpm ]]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

if [[ ! -z "$TMUX" ]]; then
  installTmuxPluginManager
fi
