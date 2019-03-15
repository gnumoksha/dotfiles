#
# Define shell aliases
# and some functions
#######################

alias l='ls --escape --classify --group-directories-first --no-group --human-readable'
alias ll='l -l'
alias la='l -l --almost-all' # --almost-all because I never want ./ and ../
alias ls_full='ll -l --author --context'

#
# Add some colors
#
# Note: color-related aliases are defined in colors.sh

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

# Copy to clipbox (Xorg)
alias cpx='xclip -sel clip'
# Copy the current path to the clipboard.
cpd() {
  print -n $PWD | cpx
}

#
# Define shell functions
#########################

# Get the value for the specified alias.
# Usage: get_alias ls
# Based on: https://unix.stackexchange.com/a/463391/273739
# The voted answer does not work if no alias is defined.
alias_get() {
  local value
  if [[ ! -z "$ZSH_VERSION" ]]; then
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

  value="$(alias_get $1)"
  if [[ -z "$value" ]]; then
    value="$1"
  fi

  alias $1="$value $2"
}

# Examples: get_password, get_password 10
# See https://www.makeuseof.com/tag/5-ways-generate-secure-passwords-linux/
# https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/
function passgen() {
	pw_length=$1
	num_pw=$2
	[ -z "$pw_length" ] && pw_length=20
	[ -z "$num_pw" ] && num_pw=1

	[ -f "$(which pwgen)" ] && pwgen --capitalize --numerals --symbols --secure --ambiguous $pw_length $num_pw
	[ -f "$(which pwgen)" ] && pwgen --capitalize --symbols --secure --ambiguous $pw_length $num_pw
	[ -f "$(which openssl)" ] && openssl rand -base64 $pw_length | head -c $pw_length; echo
	[ -f "$(which makepasswd)" ] && makepasswd --chars=$pw_length --count=$num_pw
	[ -f "$(which date)" ] && date +%s | sha256sum | base64 | head -c $pw_length; echo
	[ -f "/bin/dd" ] && dd if=/dev/urandom bs=1 count=$pw_length 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev | head -c $pw_length; echo
	< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c ${1:-$pw_length}; echo;
	tr -cd '[:alnum:]' < /dev/urandom | fold -w $pw_length | head -n 1
	# left-hand
	</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c $pw_length; echo ""
	[ -f "$(which diceware)" ] && diceware
	[ -f "$(which xkcdpass)" ] && xkcdpass
}

function public_ip () {
	wget -qO- ifconfig.co ||
	wget -qO- ifconfig.me ||
	wget -qO- icanhazip.com ||
	dig +short myip.opendns.com @resolver1.opendns.com
}

# http://stackoverflow.com/questions/1058047/wait-for-any-process-to-finish
function wait_pid() {
	for pid in "$@"; do
		while kill -0 "$pid"; do
			sleep 0.5
		done
	done
}

function psgrep () {
	ps -ef | {
		read -r;
		echo "$REPLY";
		grep "$@"
	}
}

function show_cowsay_fortune () {
	# Show fortune messages with a random cowsay character.
	# apt install fortunes-mod fortunes fortune-anarchism fortunes-br fortunes-debian-hints
	# fortunes-it fortunes-it-off fortunes-mario
	# Nota: o código rodou de primeira \o/
	# http://en.wikipedia.org/wiki/Fortune_%28Unix%29
	# http://en.wikipedia.org/wiki/Cowsay

	# Para que o fortune apareça apenas uma vez por dia
	procura=$(find /tmp -maxdepth 1 -mtime -1 -iname "*custom_fortune" -type f 2>/dev/null)
	if [[ ! -z $procura ]]; then
		return 0
	else
		mktemp --suffix=custom_fortune  2>&1 > /dev/null
	fi

	[[ -n $TMUX ]] && return 0
	[[ $(whoami) == "root" ]] && return 0
	programaFortune=$(which fortune)
	fraseFortune=''
	if [ -f $programaFortune ]; then
		fraseFortune=$($programaFortune 2>/dev/null)
	fi
	# Para quando houver mais de um pacote fortune instalado
	if [[ "$fraseFortune" == '' ]]; then
		fraseFortune=$($programaFortune /usr/share/games/fortunes/ 2>/dev/null)
	fi

	if [[ "$fraseFortune" == '' ]]; then
		fraseFortune=$(hostname)
	fi
	programaCowSay=$(which cowsay)
	if [ -f $programaCowSay ]; then
		# cowsay -l exibe os arquivos disponiveis
		diretorioCows='/usr/share/cowsay/cows'
		numeroArquivosCow=$(ls -1 $diretorioCows | wc -l)
		# http://www.cyberciti.biz/faq/bash-shell-script-generating-random-numbers/
		numeroArquivoCowAleatorio=$( echo $((RANDOM%$numeroArquivosCow-1)) )
		numeroArquivoCowAtual=0
		#TODO usar array com indice numero ao inves do for
		# ignora arquivos cow com desenhos desagradaveis
		for arquivoCow in $(ls $diretorioCows --ignore='head-in.cow' --ignore="sodomized-sheep.cow"); do
				numeroArquivoCowAtual=$(($numeroArquivoCowAtual+1))
				if [ $numeroArquivoCowAtual -eq $numeroArquivoCowAleatorio ]; then
						echo $fraseFortune | $programaCowSay -f $arquivoCow
				fi
		done
	fi
}


function show_calendar () {
	CALENDAR=$(which calendar 2> /dev/null)
	ARQUIVO_CALENDAR=~/.calendar/calendar
	CONTEUDO_ARQUIVO_CALENDAR=$( cat<<EOF
// ls /usr/share/calendar/
// alguns dos arquivo do man calendar nao existem
LANG=pt_BR.UTF-8

//#include <calendar.birthday>
#include <calendar.computer>
//#include <calendar.fictional>
//#include <calendar.lotr>
#include <calendar.debian>
#include <calendar.ubuntu>
#include <calendar.history>
#include <calendar.music>
//#include <calendar.space> not found
EOF
)
	# Para que o calendar apareça apenas uma vez por dia
	procura=$(find /tmp -maxdepth 1 -mtime -1 -iname "*bu_calendar" -type f 2>/dev/null)
	if [[ ! -z $procura ]]; then
		return 0
	else
		mktemp --suffix=bu_calendar  2>&1 > /dev/null
	fi

	if [[ -z "${CALENDAR}" ]]; then
		echo "Aplicativo calendar não encontrado"
	else
		if [ ! -f ${ARQUIVO_CALENDAR} ]; then
			echo "Criando arquivo calendar com conteúdo padrão."
			# cria diretório
			mkdir -p $(dirname "${ARQUIVO_CALENDAR}")
			# cria arquivo
			echo "$CONTEUDO_ARQUIVO_CALENDAR" > "${ARQUIVO_CALENDAR}"
		fi

		# por fim, chama o calendar exibindo apenas os eventos para a data atual
		echo "--------------------------------------------------------------------------------"
		$CALENDAR -A 1
		echo "--------------------------------------------------------------------------------"
	fi
}

show_cowsay_fortune

function fromtimestamp () {
	TZ="UTC" date -d @$1
}
function totimestamp() {
	# nao consegui usar $@
	TZ="UTC" date --date="$1 $2"  +%s
}

# https://unix.stackexchange.com/questions/202891/how-to-know-whether-wayland-or-x11-is-being-used
function isX11OrWayland() {
	echo $XDG_SESSION_TYPE ||
	loginctl show-session `loginctl|grep tobias|awk '{print $1}'` -p Type
}

# https://unix.stackexchange.com/a/86030/273739
function mans {
       man $1 | less -p "^ +$2"
}

#[ $(command -v pinfo)  ] && alias man='pinfo'
[ $(command -v nvim) ] && export MANPAGER='nvim +Man!'

cdback () { for i in $(seq 0 $1); do cd ../; done }

# cd and ls
function cdls() { cd "$@" && ls; }
alias cs='cdls'

#EOF
