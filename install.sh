#!/usr/bin/env bash
set -euo pipefail
export IFS=$'\n\t'

if [[ ! $(command -v stow) ]]; then
	echo "GNU stow not found!"
	exit 1
fi

export STOW_ARGS="--verbose=0"

if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
export INSTALLATION_DIR=$(exec 2>/dev/null;cd -- $(dirname "$FILE"); unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

# Load the profile, setting environment variables.
. "$INSTALLATION_DIR/cli/home/profile/.profile"

scripts=(
"$INSTALLATION_DIR/cli/install-home.sh"
"$INSTALLATION_DIR/cli/install-etc.sh"
"$INSTALLATION_DIR/gui/install-home.sh"
)

for script in "${scripts[@]}"; do
	. "$script"
	echo
done

unset STOW_ARGS

