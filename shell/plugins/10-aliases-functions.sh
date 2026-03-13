#!/usr/bin/env bash
#|
#| Define shell aliases and some functions
#| ---------------------------------------
#|

# Be careful and stay safe :)
alias rm='rm --interactive'
alias cp="cp --interactive"
alias mv="mv --interactive"

alias ls='ls --color=auto'
alias l='clear && ls --escape --classify --group-directories-first --no-group --human-readable'
alias ll='l -l'
alias la='l -l --almost-all' # --almost-all because I never want ./ and ../
alias ls_full='ll -l --author --context'

alias dir='dir --color=auto'

alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ip='ip --color=auto'

# a trailing space causes the next word to be checked for alias
# substitution when the alias is expanded.
# https://unix.stackexchange.com/a/25329
alias watch='watch --color '

alias dmesg="dmesg --color=auto --ctime --decode"
alias dmesg_useful="dmesg --level=notice,warn,err,crit,alert,emerg"
alias dmesg_critical="dmesg --level=crit,alert,emerg"

alias untar="tar --extract --one-top-level --file"
# Git in english
# https://githowto.com/aliases
#alias git='LANG=en_US.UTF-8 git'
alias dd="dd status=progress"
alias py="python3"
alias python-unittest="python -m unittest discover --failfast --catch --pattern '*_test.py' ."
alias g="git"
alias follow='multitail -p l '
alias follow2="less -S +F"
alias follow_monolog='multitail -p l -cS squid '
alias greperrors="grep -i 'warning\|error\|alert\|critical'"
alias pstree='ps xawf -eo pid,user,cgroup,args'
alias dfth='grc --colour=auto /usr/bin/df -x squashfs -x overlay -x tmpfs -x devtmpfs -x efivarfs -Th'

DOTFILES_USE_COLORS=${DOTFILES_USE_COLORS:-}
case "$TERM" in
xterm-color | *-256color) [[ -z "${DOTFILES_USE_COLORS}" ]] && DOTFILES_USE_COLORS=true ;;
esac

has_cmd() {
	command -v "$@" 1>/dev/null 2>&1
}

#######################################
# Execute the last command as root.
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
pls() { sudo $(fc -ln -1); }

#######################################
# Copy the current directory path to
# the clipboard.
# Arguments:
#   None
#######################################
cpd() { echo -n "$PWD" | clip "$@"; }

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

# Goes back the path x times
# Example:
#bombadil:/tmp/a/b/c$ cdback 2
#bombadil:/tmp$
# shellcheck disable=SC2034
cdback() { for i in $(seq 0 "$1"); do cd ../ || return; done; }

# Execute cd and ls
cdls() { cd "$@" && ls; }

# Check the man page for a simple parameter
# Example: mans ls -l
# https://unix.stackexchange.com/a/86030/273739
manp() { man "$1" | less -p "^ +$2"; }

# Hide zsh right prompt. Useful when copying text.
rprompt_hide() {
	RPROMPT_OLD="${RPROMPT}"
	unset RPROMPT
}

# Show zsh right prompt.
rprompt_show() {
	RPROMPT="${RPROMPT_OLD}"
	unset RPROMPT_OLD
}

python-venv() {
	python -m venv --symlinks --clear venv
	# shellcheck disable=SC1091
	source venv/bin/activate
	pip install --upgrade pip
}

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

#export PAGER=most
# https://github.com/rkitover/vimpager
#export PAGER=/opt/apps/vimpager/vimpager
#alias less=$PAGER
#alias zless=$PAGER
export PAGER=less
export LESS='-g -i -M -R -S -w -z-4'

#
# man pager
#
# Test it by running: man 2 select
# TODO use most if nvim is not available
# http://man7.org/linux/man-pages/man7/roff.7.html
# https://github.com/rtomayko/ronn
if has_cmd "bat"; then
	# reference: https://github.com/sharkdp/bat#man
	alias cat='bat'
	export MANPAGER="bat -plman"
elif has_cmd "batcat"; then
	alias cat='batcat'
	export MANPAGER="batcat -plman"
elif has_cmd "nvim"; then
	export MANPAGER='nvim +Man!'
else
	export LESS_TERMCAP_mb=$'\e[1;32m'
	export LESS_TERMCAP_md=$'\e[1;32m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_se=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[01;33m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[1;4;31m'
	#export LESS='-R --use-color -Dd+r$Du+b'
	export MANPAGER="less -R --use-color -Dd+r -Du+b"
fi

# colored GCC warnings and errors. Source: Debian's $HOME/.bashrc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# for fd package in Debian
has_cmd "fdfind" && alias fd="fdfind"

# https://github.com/eza-community/eza
has_cmd "eza" && alias ls='eza'

# https://gitlab.com/gnuwget/wget2
has_cmd "wget2" && alias wget='wget2'

# https://github.com/lsd-rs/lsd
if has_cmd "lsd"; then
	alias ls="lsd"
	alias l='lsd -l'
	alias la='lsd -a'
	alias lla='lsd -la'
	alias lt='lsd --tree'
fi

# https://github.com/baszoetekouw/pinfo
has_cmd "pinfo" && alias man='pinfo'

#
	# GRC
	#
	# Exclude fedora because there is a kind of issue with "ls" alias.
	if [[ -n "$ZSH_VERSION" && -e /etc/grc.zsh && ! -e /etc/fedora-release ]]; then
		source /etc/grc.zsh
	elif [[ -n "$BASH_VERSION" && -e /etc/grc.bashrc ]]; then
		source /etc/grc.bashrc
	fi

if [[ "$DOTFILES_USE_COLORS" == "true" ]]; then
	# https://wiki.archlinux.org/title/Color_output_in_console

	#
	# Remark
	#
	# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
	# http://savannah.nongnu.org/download/regex-markup/
	# wget -c http://download.savannah.gnu.org/releases/regex-markup/regex-markup_0.10.0-1_amd64.deb -O /tmp/regex-markup.deb
	#if [ $(command -v remark) ]; then
	#    # Do alias the command because remark adds some delay to ping
	#    ping_() { /bin/ping $@ | remark /usr/share/regex-markup/ping; }
	#    traceroute_() { /usr/sbin/traceroute $@ | remark /usr/share/regex-markup/traceroute; }
	#    diff_() { /usr/bin/diff $@ | remark /usr/share/regex-markup/diff; }
	#fi

	#
	# dircolors
	#
	# https://github.com/trapd00r/LS_COLORS
	# https://github.com/seebi/dircolors-solarized
	# https://github.com/peterhellberg/dircolors-jellybeans
	# https://github.com/arcticicestudio/nord-dircolors
	# https://github.com/KKPMW/dircolors-moonshine
	# https://github.com/karlding/dirchromatic
	# https://github.com/ivoarch/dircolors-zenburn
	# https://geoff.greer.fm/lscolors/
	# cp --link --force LS_COLORS ~/.dircolors
	#
	# enable color support of ls and also add handy aliases
	# reference: $HOME/.bashrc found on debian
	if [ -x /usr/bin/dircolors ]; then
		if has_cmd "snazzy"; then
			# https://github.com/sharkdp/vivid
			LS_COLORS="$(vivid generate molokai)"
			export LS_COLORS
		elif [ -r ~/.dircolors ]; then
			eval "$(dircolors --bourne-shell ~/.dircolors)"
		else
			eval "$(dircolors --bourne-shell)"
		fi
	fi
fi

export PATH="$PATH:$DOTFILES/bin"
