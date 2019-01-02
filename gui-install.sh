#!/usr/bin/env bash
# This script is responsible for installing
# all GUI-related stuff.

doBigChanges ()
{
	echo "Doing big changes..."

	pushd gui/home > /dev/null 2>&1
	$STOW --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1
}

addNautilusTemplates ()
{
	echo "Adding template files for Nautilus..."

	pushd gui/ > /dev/null 2>&1
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

