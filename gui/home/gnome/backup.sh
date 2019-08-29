#!/usr/bin/env bash
set -euo pipefail
export IFS=$'\n\t'

#https://unix.stackexchange.com/questions/119432/save-custom-keyboard-shortcuts-in-gnome
DCONF_DIRS=(
"/org/gnome/desktop/wm/keybindings/"
"/org/gnome/settings-daemon/plugins/media-keys/"
"/org/gnome/terminal/legacy/profiles:/:515250b1-a8cc-46f1-b692-36d0b7d515e3/"
)

BKP_DIR="output"

mkdir -p "$BKP_DIR" 2>/dev/null
PARAMS="dump"


for DCONF_DIR in "${DCONF_DIRS[@]}"; do
	name=$(basename "$DCONF_DIR")
	dconf "${PARAMS}" "${DCONF_DIR}" > "${BKP_DIR}/${name}.dconf"
done
