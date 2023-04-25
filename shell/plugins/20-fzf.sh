#!/usr/bin/env bash
# shellcheck disable=SC1117,SC1090

if [[ -n "$ZSH_VERSION" && -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -n "$BASH_VERSION" && -f ~/.fzf.bash ]]; then
  source ~/.fzf.bash
fi

# Setting fd as the default source for fzf
if [ "$(command -v fdfind)" ]; then
  FZF_DEFAULT_COMMAND='fdfind --type f'
elif [ "$(command -v fd)" ]; then
  FZF_DEFAULT_COMMAND='fd --type f'
else
  FZF_DEFAULT_COMMAND='find --type f'
fi
export FZF_DEFAULT_COMMAND
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --inline-info'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# inspired by https://gist.github.com/f440/9992963
fzf-pass-widget() {
  CMD=$1
  local FILE=
  show_pass_files() {
    local password_store=${PASSWORD_STORE_DIR-~/.password-store}
    cd "$password_store" || return > /dev/null
    find . -type f ! -name .gpg-id | sort -n | sed -e 's/\.\/\(.*\).gpg$/\1/'
  }
  FILE=$(show_pass_files | fzf)
  [ -n "$FILE" ] && pass "$CMD" "$FILE"

  zle reset-prompt
}

fzf-pass-copy-widget() {
  fzf-pass-widget "-c"
}

fzf-pass-show-widget() {
  fzf-pass-widget "show"
}

# TODO is it possible just pass the arg on zle?
fzf-pass-edit-widget() {
  fzf-pass-widget "edit"
}

fzf-pass-otp-widget() {
  fzf-pass-widget "otp"
}

fzf-kubectl-attach-widget() {
  NAMESPACE=$1
  CONTAINER=${2:-}
  local POD=

  POD=$(kubectl get pods -n "$NAMESPACE" | fzf --header-lines=1 | cut -f 1 -d ' ')
  # -c pau-pra-toda-obra
  [ -n "$POD" ] && kubectl attach -i -t --namespace="$NAMESPACE" "$POD"

  #zle reset-prompt
}

fzf-kubectl-exec-shell-widget() {
  NAMESPACE=$1
  CONTAINER=${2:-}
  local POD=

  POD=$(kubectl get pods -n "$NAMESPACE" | fzf --header-lines=1 | cut -f 1 -d ' ')
  # -c pau-pra-toda-obra
  [ -n "$POD" ] && kubectl exec --stdin --tty --namespace="$NAMESPACE" "$POD" -- sh -c "clear; (bash || ash || sh)"

  #zle reset-prompt
}

fzf-kubectl-logs-widget() {
  NAMESPACE=$1
  CONTAINER=${2:-}
  local POD=

  POD=$(kubectl get pods -n "$NAMESPACE" | fzf --header-lines=1 | cut -f 1 -d ' ')
  # -c pau-pra-toda-obra
  # --all-containers
  # --previous
  [ -n "$POD" ] && kubectl logs --follow --namespace="$NAMESPACE" "$POD"

  #zle reset-prompt
}

if [ -n "$ZSH_VERSION" ]; then
  zle     -N    fzf-pass-copy-widget
  bindkey '^Pc' fzf-pass-copy-widget
  zle     -N    fzf-pass-edit-widget
  bindkey '^Pe' fzf-pass-edit-widget
  zle     -N    fzf-pass-show-widget
  bindkey '^Ps' fzf-pass-show-widget
  zle     -N    fzf-pass-otp-widget
  bindkey '^Po' fzf-pass-otp-widget
fi

#TODO for bash
# TODO fzf has modifiers? Send c/e/s to fzf.
#TODO copy login too (as second register?)

