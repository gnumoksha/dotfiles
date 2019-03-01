#!/usr/bin/env bash
# This script is responsible to install
# all cli-related stuff.

if [[ -z "$STOW" ]]; then
	echo "You need to set STOW variable"
	exit 1
fi

if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
CURRENT_DIR=$(exec 2>/dev/null;cd -- $(dirname "$FILE"); unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

STOW_IN_HOME=(
"$CURRENT_DIR/home/bash" # http://savannah.gnu.org/support/?108134
"$CURRENT_DIR/home/ctags"
"$CURRENT_DIR/home/legacy_to_xdg"
"$CURRENT_DIR/home/ssh" # https://bugzilla.mindrot.org/show_bug.cgi?id=2050
)

for item in "${STOW_IN_HOME[@]}"; do
	if [[ -f "$tem" ]]; then
		continue
	fi
	item_directory=$(dirname $item)
	item_basename=$(basename $item)

	echo "Installing $item_basename in $HOME"

	pushd "$item_directory" > /dev/null 2>&1
	$STOW --target="$HOME" "$item_basename"
	popd > /dev/null 2>&1
	echo
done

echo "Installing configs in $XDG_CONFIG_HOME"
pushd "$CURRENT_DIR/home/" > /dev/null 2>&1
$STOW --target="$XDG_CONFIG_HOME/" config/
popd > /dev/null 2>&1
echo

