#!/usr/bin/env bash
set -euo pipefail
export IFS=$'\n\t'

DEBUG_ENABLED="false"

is_debug_enabled() {
	[[ "${DEBUG_ENABLED}" == "true" ]]
}

log_debug() {
	if is_debug_enabled; then
		echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [debug]: $*"
	fi
}
log_error() {
	echo "❌ $*"
}

extract_dotfiles_info() {
	local path=${1:-}
    local -n __result=${2:-}

	# XXX what happens if more then of info exists?
	raw_info=$(sed -nr '/#( )?dotfiles( )?:( )?/p' "$path")
	raw_info=$(echo "$raw_info" | sed -r 's/#( )?dotfiles( )?:( )?//i')
	if [[ ! -z "$raw_info" ]]; then
		log_debug "will evaluate '$raw_info'"
		__result=$(eval "$raw_info"; echo $destination)
		return
	fi

	# shellcheck disable=SC2034
	__result=
}

create_link() {
	local origin=${1}
	local destination=${2:-}
	local -n __result=${3:-}
	local force_fail=${4:-}

	log_debug "Called to create a link between '$origin' and '$destination'."

	if [[ $(basename "$origin") == "." ]]; then # origin is the directory where the .dotfilesrc is in
		origin=$(dirname "$origin")
	fi

	if [[ -z "$destination" ]]; then
		__result=$(log_error "destination is empty")
		return
	fi

	if [[ $destination == */ ]]; then # destination is a directory
		destination="${destination}$(basename "${origin}")"
		destination_type="directory"
	else # destination is a full path to a file
		# remove lst / in order to be able to check if it exists (in case it is a link)
		destination=${destination%/}
		destination_type="path"
	fi

	if [[ -h "$destination" ]]; then
		log_debug "destination exists and is a symbolic link, so it will be removed."
		rm -f "$destination"
	fi

	if [[ -e "$destination" ]]; then
		if [[ "$force_fail" == "yes" ]]; then
			__result=$(log_error "destination '$destination' already exists")
			return
		fi

		pushd "$origin" >/dev/null 2>&1
		for i in **; do
			create_link "$origin/$i" "$destination/$i" foo "yes"
		done
		popd >/dev/null 2>&1
		__result="✅ files linked within the directory ${destination}"
		return
	fi

	ln -s "$origin" "$destination"
	__result="✅ linked to ${destination_type} ${destination}"
}

process() {
	local full_path=${1:-}

	log_debug "Processing .dotfilesrc files"
	shopt -s dotglob globstar nullglob
	for item in "$full_path"/**/.dotfilesrc; do
		log_debug "Processing $item"
		declare -A info

		while IFS= read -r line; do
			regex="src=(.*) dst=(.*)"
			if [[ ! $line =~ $regex ]]; then
				echo "Unable to parse '$line' in file '$item'."
				return 1
			fi

			str_raw="echo ${BASH_REMATCH[1]}"
			log_debug "Will evaluate '$str_raw' from dotfilesrc"
			info[src]="$full_path/$(eval "$str_raw")"

			dst_raw="echo ${BASH_REMATCH[2]}"
			log_debug "Will evaluate '$dst_raw' from dotfilesrc"
			info[dst]=$(eval "$dst_raw")

			if is_debug_enabled; then
				log_debug "Processing ${info[src]} (via $item): "
			else
				echo -n "$(basename "${info[src]}")/: "
			fi
			
			create_link "${info[src]}" "${info[dst]}" msg
			echo "$msg"

			if is_debug_enabled; then
				echo
			fi
		done < "$item"
	done

	log_debug "Processing common files"
	shopt -u dotglob
	local destination
	for item in "$full_path"/**; do
		if [[ ! -f "$item" ]]; then
			continue
		fi
		extract_dotfiles_info "$item" destination

		if [[ -z "$destination" ]]; then
			continue
		fi

		if is_debug_enabled; then
			log_debug "Processing $item: "
		else
			echo -n "$(basename "$item"): "
		fi

		create_link "$item" "$destination" msg
		echo "$msg"

		if is_debug_enabled; then
			echo
		fi
	done
}

main() {
	declare INSTALLATION_DIR
	# shellcheck disable=SC2128
	if [ ! -z "$BASH_SOURCE" ]; then FILE="${BASH_SOURCE[0]}"; else FILE="$0"; fi
	INSTALLATION_DIR=$(exec 2>/dev/null;cd -- "$(dirname "$FILE")"; unset PWD; /usr/bin/pwd || /bin/pwd || pwd)

	for arg in "$@"; do
		case ${arg} in
			--debug)
				DEBUG_ENABLED="true"
				;;
			--verbose-debug)
				DEBUG_ENABLED="true"
				set -x
				;;
		esac
	done

	for directory in config icons; do
		process "$INSTALLATION_DIR/$directory"
	done

	log_debug "Successfully finished"
}

main "$@"
