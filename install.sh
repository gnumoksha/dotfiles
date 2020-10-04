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
        src_symbol='/'
    else # destination is a full path to a file
        # remove lst / in order to be able to check if it exists (in case it is a link)
        destination=${destination%/}
        src_symbol=''
    fi

    if [[ -h "$destination" ]]; then
        log_debug "destination exists and is a symbolic link, so it will be removed."
        rm -f "$destination"
    fi

    if [[ -e "$destination" ]]; then
        log_debug "Destination $destination already exists"
        if [[ "$force_fail" == "yes" ]]; then
            __result=$(log_error "destination '$destination' already exists")
            return
        fi

        pushd "$origin" >/dev/null 2>&1
        for i in **; do
            create_link "$origin/$i" "$destination/$i" foo "yes"
        done
        popd >/dev/null 2>&1
        __result="✅ files linked within ${destination}${src_symbol}"
        return
    fi

    ln -s "$origin" "$destination"
    __result="✅ linked to ${destination}${src_symbol}"
}

process_statement() {
    local statement=${1}
	local full_path=${2}

    log_debug "Will evaluate '$statement'."
    evaluated=$( eval "declare -A info
				info[src]=; src=;
				info[dst]=; dst=;
				info[execBefore]=; execBefore=;
				$statement
				[[ ! -z "\$src" ]] && info[src]=$full_path/\$src
				info[dst]=\$dst
				info[execBefore]=\$execBefore
        typeset -p info"
    )
    eval "$evaluated"

    if [[ -z "${info[src]}" ]] ; then
        log_debug "Skipping empty statement."
        return
    fi

	if [[ -d "${info[src]}" ]] ; then
		src_symbol='/'
	else
		src_symbol=''
	fi

    if is_debug_enabled; then
        log_debug "Processing ${info[src]}:"
	elif [[ $(basename "${info[src]}") == '.' ]]; then
		printf "%-20.20s" "$(basename "$(dirname "${info[src]}")")${src_symbol}"
    else
        printf "%-20.20s" "$(basename "${info[src]}")${src_symbol}"
    fi

    if [[ ! -z "${info[execBefore]}" ]]; then
        log_debug "Will execute: ${info[execBefore]}"
        eval "${info[execBefore]}" # this command must return 0, otherwise the script will stop
    fi

    create_link "${info[src]}" "${info[dst]}" msg
    echo "$msg"

    if is_debug_enabled; then
        echo
    fi
}

process_path() {
    local full_path=${1}

    log_debug "Processing .dotfilesrc files"
    shopt -s dotglob globstar nullglob
    for item in "$full_path"/**/.dotfilesrc; do
        log_debug "Processing $item"
        local info=

        while IFS= read -r line; do
            process_statement "$line" "$full_path"
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
            printf "%-20.20s" "$(basename "$item") "
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
        process_path "$INSTALLATION_DIR/$directory"
    done

    log_debug "Successfully finished"
}

main "$@"

