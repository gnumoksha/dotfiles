#!/usr/bin/env bash
#|
#| Define shell aliases and some functions
#| ---------------------------------------
#|
# shellcheck disable=SC1117

#|
#| Aliases
#|
# Note: color-related aliases are defined in colors.sh
alias l='clear && ls --escape --classify --group-directories-first --no-group --human-readable'
alias ll='l -l'
alias la='l -l --almost-all' # --almost-all because I never want ./ and ../
alias ls_full='ll -l --author --context'
# Be careful and stay safe :)
alias rm='rm --interactive'
alias cp="cp --interactive"
alias mv="mv --interactive"
# Nice format :)
alias dmesg="dmesg --color --ctime --decode"
alias dmesg_useful="dmesg --level=notice,warn,err,crit,alert,emerg"
alias dmesg_critical="dmesg --level=crit,alert,emerg"
# Git in english
# https://githowto.com/aliases
#alias git='LANG=en_US.UTF-8 git'
alias dd="dd status=progress"
alias py="python3"
py3venv() { python3 -m venv --symlinks --clear --prompt "$(basename "$(pwd)")" venv;}
alias fd="fdfind"
alias g="git"
alias follow='multitail -p l '
alias follow2="less -S +F"
alias follow_monolog='multitail -p l -cS squid '
alias greperrors="grep -i 'warning\|error\|alert\|critical'"
# see https://github.com/wfxr/forgit#custom-options
alias git-add="ga"
alias git-log="glo"
alias git-diff="gd"
alias git-checkout="gcf"
alias git-clean="gclan"
alias git-ignore="git"

#######################################
# Execute the last command as root.
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
pls() { sudo $(fc -ln -1); }

#######################################
# Copy buffer to the Xorg's clipboard.
# Arguments:
#   None
#   Text to send to clipboard.
#######################################
cpb() {
  if [[ $# -eq 0 ]]; then
    input=$(</dev/stdin)
  else
    input=( "$@" )
  fi

  echo -n "${input[@]}" | xclip -sel clip;
}

#######################################
# Copy the current directory path to
# the clipboard.
# Arguments:
#   None
#######################################
cpd() { echo -n "$PWD" | cpb "$@"; }

# Change to the file's directory
cdf() {
	local dest=${1:-}
	if [[ ! -f "$dest" ]]; then
		echo "$dest is not a file" >&2
		return 1
	fi
	cd "$(dirname "$dest")" || exit 2
}

# Create the directory and change to it
mkcd() { mkdir -p "$1" && cd "$1" || return; }

# Returns the path x times
# Example:
#bombadil:/tmp/a/b/c$ cdback 2
#bombadil:/tmp$
# shellcheck disable=SC2034
cdback() { for i in $(seq 0 "$1"); do cd ../ || return; done }
alias cdb="cdback"

# Execute cd and ls
cdls() { cd "$@" && ls; }; alias cs='cdls'

# Check the man page for a simple parameter
# Example: mans ls -l
# https://unix.stackexchange.com/a/86030/273739
manp() { man "$1" | less -p "^ +$2"; }

# Hide zsh right prompt. Useful when copying text.
rprompt_hide() { RPROMPT_OLD="${RPROMPT}"; unset RPROMPT; }
rprompt_show() { RPROMPT="${RPROMPT_OLD}"; unset RPROMPT_OLD; }

# Get the value for the specified alias.
# Usage: get_alias ls
# Based on: https://unix.stackexchange.com/a/463391/273739
# The voted answer does not work if no alias is defined.
alias_get() {
  local value
  if [[ -n "$ZSH_VERSION" ]]; then
    # shellcheck disable=SC2154
    value="${aliases[$1]}"
  else
    value="${BASH_ALIASES[$1]}"
  fi

  if [[ -n "$value" ]]; then
    echo "$value"
  else
    echo -n
  fi
}
# Append something to an existent alias.
# Usage alias_append "some-alias" "foo bar"
alias_append() {
  local value

  value="$(alias_get "$1")"
  if [[ -z "$value" ]]; then
    value="$1"
  fi

  # shellcheck disable=SC2139,SC2086
  alias $1="$value $2"
}


# http://stackoverflow.com/questions/1058047/wait-for-any-process-to-finish
wait_pid() {
  for pid in "$@"; do
    while kill -0 "$pid"; do
      sleep 0.5
    done
  done
}

psgrep () {
  ps -ef | {
    read -r;
      echo "$REPLY";
      grep "$@"
    }
}
psgrep2 () {
  [[ $(command -v grc) ]] && PS=(grc --colour=auto /usr/bin/ps) || PS=(ps)
  PS+=(-f -C "$@")
  "${PS[@]}"
}

# man ps
# STANDARD FORMAT SPECIFIERS

alias pstree='ps xawf -eo pid,user,cgroup,args'
# ps -O %cpu,%mem,nice,rssize,trs,vsz,wchan

find_in_files () {
  what=$1
  where=$2
  # searches the complete word on txt and md files
  grep --include=\*.{txt,md} -Rniwa "${where}" -e "${what}"
}

#[ $(command -v pinfo)  ] && alias man='pinfo'
# TODO if tiver most e nao nvim, usar most
# http://man7.org/linux/man-pages/man7/roff.7.html
# https://github.com/rtomayko/ronn
[ "$(command -v nvim)" ] && export MANPAGER='nvim +Man!'
#export LESS_TERMCAP_mb=$'\e[1;32m'
#export LESS_TERMCAP_md=$'\e[1;32m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'

#EOF