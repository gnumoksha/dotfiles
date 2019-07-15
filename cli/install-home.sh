#!/usr/bin/env bash
# This script is responsible to install
# all cli-related stuff.

STOW_IN_HOME=(
"$INSTALLATION_DIR/cli/home/profile"
"$INSTALLATION_DIR/cli/home/bash" # http://savannah.gnu.org/support/?108134
"$INSTALLATION_DIR/cli/home/ctags"
"$INSTALLATION_DIR/cli/home/zshenv"
"$INSTALLATION_DIR/cli/home/ssh" # https://bugzilla.mindrot.org/show_bug.cgi?id=2050
"$INSTALLATION_DIR/cli/home/grc"
"$INSTALLATION_DIR/cli/home/xorg"
)

for item in "${STOW_IN_HOME[@]}"; do
	if [[ -f "$item" ]]; then
		continue
	fi
	item_directory=$(dirname $item)
	item_basename=$(basename $item)

	printf "\rInstalling %-15s at %-15s\n" $item_basename $HOME

	pushd "$item_directory" > /dev/null 2>&1
	stow "$STOW_ARGS" --target="$HOME" "$item_basename"
	if [[ $? -ne 0 ]]; then
		>&2 echo "Error while executing GNU stow!"
		echo
	fi
	popd > /dev/null 2>&1
done

printf "\rInstalling %-15s at %-15s\n" "configs" $XDG_CONFIG_HOME
pushd "$INSTALLATION_DIR/cli/home/" > /dev/null 2>&1
stow "$STOW_ARGS" --target="$XDG_CONFIG_HOME/" config/
if [[ $? -ne 0 ]]; then
	>&2 echo "Error while executing GNU stow!"
	echo
fi
popd > /dev/null 2>&1

mkdir -p "$XDG_CACHE_HOME"/vim/{undo,swap,backup} 2>/dev/null
mkdir -p "$XDG_CACHE_HOME"/nvim/{undo,swap,backup} 2>/dev/null

