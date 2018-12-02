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
echo

doBigChanges ()
{
	echo "Doing big changes..."

	pushd big-changes/home > /dev/null 2>&1
	$STOW --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1
}

addNautilusTemplates ()
{
	echo "Adding template files for Nautilus..."

	pushd big-changes/ > /dev/null 2>&1
	$STOW --target=$(xdg-user-dir TEMPLATES) nautilus-file-templates/
	popd > /dev/null 2>&1
}

echo "Do you want to do the big changes?"
select big_changes in "Yes" "No"; do
	if [[ $big_changes == 'Yes' ]]; then
		doBigChanges
	fi
	echo
	break
done

echo "Do you want to add template files for Nautilus (A.K.A Files)?"
select template_files in "Yes" "No"; do
	if [[ $template_files == 'Yes' ]]; then
		addNautilusTemplates
	fi
	echo
	break
done

echo "Finished."

