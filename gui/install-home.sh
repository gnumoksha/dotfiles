#!/usr/bin/env bash
# This script is responsible to install
# all GUI-related stuff.

if [[ -z "$STOW" ]]; then
	echo "You need to set STOW variable"
	exit 1
fi

if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
CURRENT_DIR=$(exec 2>/dev/null;cd -- $(dirname "$FILE"); unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

doBigChanges ()
{
	echo "Configuring GUI stuff under $HOME"

	pushd "$CURRENT_DIR/home" > /dev/null 2>&1
	$STOW --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1
}

addNautilusTemplates ()
{
	echo "Adding template files for Nautilus"

	pushd "$CURRENT_DIR" > /dev/null 2>&1
	$STOW --target=$(xdg-user-dir TEMPLATES) nautilus-file-templates/
	popd > /dev/null 2>&1
}

echo "Do you want to configure GUI-related stuff under your HOME directory?"
select big_changes in "Yes" "No"; do
	if [[ $big_changes == 'Yes' ]]; then
		doBigChanges
	fi
	echo
	break
done

echo "Do you want to add template files for Gnome Files (A.K.A Nautilus)?"
select template_files in "Yes" "No"; do
	if [[ $template_files == 'Yes' ]]; then
		addNautilusTemplates
	fi
	echo
	break
done

