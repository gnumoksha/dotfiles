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
alias l='ls --escape --classify --group-directories-first --no-group --human-readable'
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

# Copy buffer to the Xorg's clipboard.
cpb() { echo "$@" | xclip -sel clip; }

# Copy the current directory path to the clipboard.
cpd() { cpb "$(echo -n "$PWD")"; }

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

# Execute cd and ls
cdls() { cd "$@" && ls; }; alias cs='cdls'

# TODO use $@
totimestamp() { TZ="UTC" date --date="$1 $2"  +%s; }
# Convert unix timestamp to date
fromtimestamp () { TZ="UTC" date -d "@$1" "+%F %T %Z"; }

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
  if [[ ! -z "$ZSH_VERSION" ]]; then
    # shellcheck disable=SC2154
    value="${aliases[$1]}"
  else
    value="${BASH_ALIASES[$1]}"
  fi

  if [[ ! -z "$value" ]]; then
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

# Generate passwords.
# Usage: passgen <length>
# Examples:
# passgen
# passgen 10
# Resources:
# https://www.makeuseof.com/tag/5-ways-generate-secure-passwords-linux/
# https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/
passgen() {
  pw_length=${1:-}
  num_pw=${2:-}
  [[ -z "$pw_length" ]] && pw_length=20
  [[ -z "$num_pw" ]] && num_pw=1

  pp() { printf "%-10s" "$@"; }

  printf "> strong password: \n"

  [[ $(command -v pwgen) ]] && \
    pp "pwgen: " && \
    pwgen --capitalize --numerals --symbols --secure --ambiguous \
    $pw_length $num_pw

  pp "urandom: " && \
    < /dev/urandom tr -dc 'A-Z-a-z-0-9!@#$%^&*+-' | \
    head -c "${1:-$pw_length}"; echo

  printf "\n> simple password: \n"

  [[ $(command -v pwgen) ]] && \
    pp "pwgen: " && \
    pwgen $pw_length $num_pw;

  pp "urandom" && \
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | \
    head -c "${1:-$pw_length}"; echo;

  [[ $(command -v openssl) ]] && \
    pp "openssl: " && \
    openssl rand -base64 $pw_length | \
    head -c "$pw_length"; echo;

  # makepasswd is too simple
  #[[ $(command makepasswd) ]] && \
    #pp "makepasswd: " && \
    #makepasswd --chars=$pw_length --count=$num_pw;

  printf "\n> Other types: \n"

  # left-hand password, which would let you type your password with one hand.
  pp "lefthand: " && \
    </dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | \
    head -c $pw_length; echo

  [[ $(command -v diceware) ]] && \
    pp "diceware: " && \
    diceware

  # https://github.com/redacted/XKCD-password-generator
  [[ $(command -v xkcdpass) ]] && \
    pp "xkcdpass: " && \
    xkcdpass --numwords=3 --delimiter=@ --case=random --count "$num_pw";
    pp "acrostic: " && \
    xkcdpass --acrostic "${USER}" --count "$num_pw"

  # #TODO https://xkpasswd.net/s/

  unset pp
}

# returns the public ip of this host.
public_ip () {
  wget -qO- ifconfig.co ||
    wget -qO- ifconfig.me ||
    wget -qO- icanhazip.com ||
    dig +short myip.opendns.com @resolver1.opendns.com
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
