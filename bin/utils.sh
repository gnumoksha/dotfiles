DOTFILES_BIN_DEBUG=${DOTFILES_BIN_DEBUG:-}
debug_is_enabled() {
  [[ "${DOTFILES_BIN_DEBUG:-}" == "true" ]]
}

logger_debug() {
  if debug_is_enabled; then
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [debug]: $@"
  fi
}

logger_info() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [info]: $@"
}

logger_error() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [error]: $@" >&2
}

assert_is_linux() {
  OS=$(uname -s)
  if [[ "$OS" != "Linux" ]]; then
    echo "Error: OS $OS is not supported" >&2
    exit 1
  fi
}

is_debian() {
  if [[ -n "$(command -v apt)" ]]; then
    true
  else
    false
  fi
}

is_fedora() {
  # TODO cat /etc/os-release | grep "^ID="
  if [[ -n "$(command -v dnf)" ]]; then
    true
  else
    false
  fi
}

is_archlinux() {
  if [[ -n "$(command -v pacman)" ]]; then
    true
  else
    false
  fi
}

has_cmd() {
  command -v "$1" 1>/dev/null 2>&1
}

input_yes_or_no() {
  while true; do
    read -p "$* [y/n]: " yn
    case $yn in
    [Yy]*) return 0 ;;                    # Return 0 for 'yes' (success)
    [Nn]*) return 1 ;;                    # Return 1 for 'no' (failure)
    *) echo "Please answer yes or no." ;; # Invalid input, loop continues
    esac
  done
}
