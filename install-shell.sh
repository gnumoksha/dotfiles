#!/usr/bin/env bash
# This script is responsible for installing
# all shell-related stuff.

# path relative to the CURRENT DIR.
STOW_IN_HOME=(
'shell/home/ctags'
'shell/home/legacy_to_xdg'
'shell/home/ssh'
)

for item in "${STOW_IN_HOME[@]}"; do
	if [[ -f "$tem" ]]; then
		continue
	fi
	item_directory=$(dirname $item)
	item_basename=$(basename $item)

	echo "Installing $item_basename in $HOME..."

	pushd "$item_directory" > /dev/null 2>&1
	$STOW --target="$HOME" "$item_basename"
	popd > /dev/null 2>&1
	echo
done

echo "Installing configs in $XDG_CONFIG_HOME..."
pushd shell/home/ > /dev/null 2>&1
$STOW --target="$XDG_CONFIG_HOME/" config/
popd > /dev/null 2>&1
echo

