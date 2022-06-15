#!/usr/bin/env bash
set -euo pipefail
export IFS=$'\n\t'

DEBUG_ENABLED=${DEBUG_ENABLED:-"false"}

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

# full path
extract_inline_statement() {
    local path=${1:-}
    local -n __result=${2:-}

    tag=$(sed -nr '/#( )?dotfiles( )?:( )?/p' "$path")
    content=$(echo "$tag" | sed -rn 's/.*#( )?dotfiles( )?:( )?/\3/pi' | head -1)
    if [[ ! -z "$content" ]]; then
        #log_debug "File \"$path\" has in-line statement \"$content\"."
        #FIXME check if $content already has src
        __result="src=$path $content"
        return
    fi

    # shellcheck disable=SC2034
    __result=
}

# Process a statement like
# src=file dst=/destination/directory_or_file execBefore=ls execAfter=ls
process_statement() {
    local statement=${1}
    local base_path=${2}

    log_debug "Evaluating the statement \"$statement\"."
    # it is necessary to declare the variables first to avoid "unbound variable" errors
    evaluated=$( eval "declare -A info
				info[src]=; src=;
				info[dst]=; dst=;
				info[execBefore]=; execBefore=;
				info[execAfter]=; execAfter=;
				$statement
				if [[ ! -z "\$src" ]]; then
          if [[ ! -z \"$base_path\" ]]; then
            info[src]=$base_path/\$src
          else
            info[src]=\$src
          fi
        fi
				info[dst]=\$dst
				info[execBefore]=\$execBefore
				info[execAfter]=\$execAfter
        typeset -p info"
    )
    eval "$evaluated"

    if [[ -z "${info[src]}" ]] ; then
        log_debug "Skipping the statement because it has no \"src\" field."
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
        log_debug "Executing \"execBefore\": ${info[execBefore]}"
        eval "${info[execBefore]}" # this command must return 0, otherwise the script will stop
    fi

    create_link "${info[src]}" "${info[dst]}" msg
    echo "$msg"

    if [[ ! -z "${info[execAfter]}" ]]; then
        log_debug "Executing \"execAfter\": ${info[execAfter]}"
        eval "${info[execAfter]}" # this command must return 0, otherwise the script will stop
    fi

    if is_debug_enabled; then
        echo
    fi
}

# origin and destination must be the full path
create_link() {
    local origin=${1}
    local destination=${2:-}
    local -n __result=${3:-}
    local force_fail=${4:-}

    log_debug "Creating link $origin ➡️ $destination."

    if [[ $(basename "$origin") == "." ]]; then
        # origin is the directory where the .dotfilesrc is in
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
        log_debug "Destination exists and it is a symbolic link, so it will be removed."
        rm -f "$destination"
    fi

    if [[ -e "$destination" ]]; then
        log_debug "Destination $destination already exists"
        if [[ "$force_fail" == "yes" ]]; then
            __result=$(log_error "destination '$destination' already exists")
            return
        fi

        if [[ ! -d "$origin" ]]; then
            log_error "file $destination already exists"
            exit 1
        fi
        pushd "$origin" >/dev/null
        for i in **; do
            create_link "$origin/$i" "$destination/$i" foo "yes"
        done
        popd >/dev/null
        __result="✅ files linked within ${destination}${src_symbol}"
        return
    fi

    # TODO check if parent dir exists
    ln -s "$origin" "$destination"
    __result="✅ linked to ${destination}${src_symbol}"
}

process_dotfilesrc_files() {
    local full_path=${1}

    log_debug "Searching .dotfilesrc files in $full_path"
    shopt -s dotglob globstar nullglob
    for item in "$full_path"/**/.dotfilesrc; do
        log_debug "Analysing dotfilesrc file at $item"
        local info=

        while IFS= read -r line; do
            process_statement "$line" "$full_path"
        done < "$item"
    done
}

process_inline_statements() {
    local full_path=${1}

    log_debug "Searching in-line statements in files under $full_path"
    shopt -s dotglob globstar nullglob
    local destination
    for item in "$full_path"/**; do
        if [[ ! -f "$item" ]]; then
            continue
        fi

        extract_inline_statement "$item" statement
        if [[ -z "$statement" ]]; then
            continue
        fi

        if is_debug_enabled; then
            log_debug "Processing in-line statement \"$statement\" from file \"$item\"."
        else
            printf "%-20.20s" "$(basename "$item") "
        fi

        process_statement "$statement" ""

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

    for directory in config icons bin; do
        process_dotfilesrc_files "$INSTALLATION_DIR/$directory"
        process_inline_statements "$INSTALLATION_DIR/$directory"
    done

    log_debug "Successfully finished"
}

# set default values for some XDG environment variables, if not set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

main "$@"

echo "done"
