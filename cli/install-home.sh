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
"$CURRENT_DIR/home/profile"
"$CURRENT_DIR/home/bash" # http://savannah.gnu.org/support/?108134
"$CURRENT_DIR/home/ctags"
"$CURRENT_DIR/home/zshenv"
"$CURRENT_DIR/home/ssh" # https://bugzilla.mindrot.org/show_bug.cgi?id=2050
"$CURRENT_DIR/home/grc"
"$CURRENT_DIR/home/xorg"
)

for item in "${STOW_IN_HOME[@]}"; do
	if [[ -f "$tem" ]]; then
		continue
	fi
	item_directory=$(dirname $item)
	item_basename=$(basename $item)

	printf "\rInstalling %-15s at %-15s\n" $item_basename $HOME

	pushd "$item_directory" > /dev/null 2>&1
	$STOW --target="$HOME" "$item_basename"
	if [[ $? -ne 0 ]]; then
		>&2 echo "Error while executing GNU stow!"
		echo
	fi
	popd > /dev/null 2>&1
done

printf "\rInstalling %-15s at %-15s\n" "configs" $XDG_CONFIG_HOME
pushd "$CURRENT_DIR/home/" > /dev/null 2>&1
$STOW --target="$XDG_CONFIG_HOME/" config/
if [[ $? -ne 0 ]]; then
	>&2 echo "Error while executing GNU stow!"
	echo
fi
popd > /dev/null 2>&1

mkdir -p "$XDG_CACHE_HOME"/vim/{undo,swap,backup} 2>/dev/null
mkdir -p "$XDG_CACHE_HOME"/nvim/{undo,swap,backup} 2>/dev/null

