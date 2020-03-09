#!/usr/bin/env bash
# This script is responsible to install all GUI-related stuff.
set -euo pipefail
export IFS=$'\n\t'

if [[ $(id -u) == 0 ]]; then
	echo "Note: do not offering GUI changes for the root user."
	return 0
fi

doBigChanges () {
	echo "Configuring GUI stuff under $HOME"

	pushd "$INSTALLATION_DIR/gui/home" > /dev/null 2>&1
	stow "$STOW_ARGS" --target="$XDG_CONFIG_HOME/" config/
	popd > /dev/null 2>&1
}

addNautilusTemplates () {
	echo "Adding template files for Nautilus"

	pushd "$INSTALLATION_DIR/gui/home" > /dev/null 2>&1
	destination=$(xdg-user-dir TEMPLATES)
	if [[ -z "${destination}" ]]; then
		echo "Unable to get XDG user dir for templates"
		exit 1
	fi
	if [[ "${destination}" == "${HOME}" ]]; then
		echo "Nautilus templates directory is equals to $HOME. This is probably wrong."
		exit 1
	fi
	stow "$STOW_ARGS" --target=${destination} nautilus-file-templates/
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

