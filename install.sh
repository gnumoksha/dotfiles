#!/usr/bin/env bash

STOW="$(which stow) --verbose=0"
# path relative to the CURRENT DIR.
STOW_IN_HOME=(
'home/ctags'
'home/legacy_to_xdg'
'home/ssh'
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

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}

echo "Installing configs in $XDG_CONFIG_HOME..."
pushd home/ > /dev/null 2>&1
$STOW --target="$XDG_CONFIG_HOME/" config/
popd > /dev/null 2>&1

function doBigChanges {
	echo "Doing big changes..."

	pushd big-changes/home > /dev/null 2>&1
	$STOW --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1

	echo
}

echo "Do you want to do the big changes?"
select big_changes in "Yes" "No"; do
	if [[ $big_changes == 'Yes' ]]; then
		doBigChanges
	fi
	break
done

echo "Finished."

