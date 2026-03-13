#!/usr/bin/env bash

# shellcheck disable=SC2034
declare -A COLORS=(
	["brown"]="\[\033[00;33m\]"
	["black"]="\[\033[00;30m\]"
	["white"]="\[\033[01;37m\]"
	["yellow"]="\[\033[01;33m\]"
	["light_green"]="\[\033[01;32m\]"
	["light_blue"]="\[\033[01;34m\]"
	["light_purple"]="\[\033[01;35m\]"
	["yellow_red"]="\[\033[01;33;41m\]"
	["underline"]="\[\033[00;4m\]"
	["none"]="\[\033[00m\]"
)

DOTFILES_BIN_DEBUG=${DOTFILES_BIN_DEBUG:-}
debug_is_enabled() {
	[[ "${DOTFILES_BIN_DEBUG:-}" == "true" ]]
}

logger_debug() {
	if debug_is_enabled; then
		echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [debug]: $*"
	fi
}

logger_info() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [info]: $*"
}

logger_error() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [error]: $*" >&2
}

assert_is_linux() {
	OS=$(uname -s)
	if [[ "$OS" != "Linux" ]]; then
		echo "Error: OS $OS is not supported" >&2
		exit 1
	fi
}

get_distribution() {
	if [ -r /etc/os-release ]; then
		# shellcheck disable=SC1091
		. /etc/os-release && echo "$ID" | tr '[:upper:]' '[:lower:]'
		return
	fi

	logger_error "Unable to determine Linux distribution"
}

is_debian() {
	if [[ "$(get_distribution)" == "debian" ]]; then
		true
	else
		false
	fi
}

is_ubuntu() {
	if [[ "$(get_distribution)" == "ubuntu" ]]; then
		true
	else
		false
	fi
}

is_fedora() {
	if [[ "$(get_distribution)" == "fedora" ]]; then
		true
	else
		false
	fi
}

is_archlinux() {
	if [[ "$(get_distribution)" == "arch" ]]; then
		true
	else
		false
	fi
}

# Example:
# if has_cmd foo; then echo "yes"; fi
has_cmd() {
	command -v "$1" 1>/dev/null 2>&1
}

# Example:
# if input_yes_or_no "Foo?"; then echo "Foo!"; fi
input_yes_or_no() {
	while true; do
		# shellcheck disable=SC2162
		read -p "$1 (y/n)? " yn
		case $yn in
			[Yy]* ) return 0;; # Return 0 for 'yes' (true in bash)
			[Nn]* ) return 1;; # Return 1 for 'no' (false in bash)
			* ) echo "Invalid response, please answer yes or no.";;
		esac
	done
}
