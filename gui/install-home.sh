#!/usr/bin/env bash
# This script is responsible to install
# all GUI-related stuff.

if [[ $(id -u) == 0 ]]; then
	echo "Note: do not offering GUI changes for the root user."
	exit 0
fi

if [[ -z "$STOW" ]]; then
	echo "You need to set STOW variable"
	exit 1
fi

if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
CURRENT_DIR=$(exec 2>/dev/null;cd -- $(dirname "$FILE"); unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

doBigChanges () {
	echo "Configuring GUI stuff under $HOME"

	pushd "$CURRENT_DIR/home" > /dev/null 2>&1
	$STOW --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1
}

addNautilusTemplates () {
	echo "Adding template files for Nautilus"

	pushd "$CURRENT_DIR/home" > /dev/null 2>&1
	destination=$(xdg-user-dir TEMPLATES)
	if [[ -z "${destination}" ]]; then
		echo "Unable to get XDG user dir for templates"
		exit 1
	fi
	$STOW --target=${destination} nautilus-file-templates/
	popd > /dev/null 2>&1
}

echo "Do you want to configure GUI-related stuff under your HOME directory?"
select big_changes in "Yes" "No"; do
	if [[ $big_changes == 'Yes' ]]; then
		doBigChanges

		addNautilusTemplates
	fi
	break
done

