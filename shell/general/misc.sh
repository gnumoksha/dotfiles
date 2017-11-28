###################################
#               PATH              #
###################################
# Para o debian
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/games"
# PHP composer
export PATH="$PATH:~/.config/composer/vendor/bin"
# Binarios extras sem instalador para debian
export PATH="/opt/_apps/_gnu+linux/_bin:$PATH"
# Python
export PATH="$PATH:/home/tobias/.local/bin"

# For Golang
export GOPATH=/usr/src/tobias/go

###################################
#            FUNCTIONS            #
###################################

# Examples: my_get_password, my_get_password 10 
function my_get_password() {
	pwgen --capitalize --num-passwords=1 --numerals --secure --symbols $@
}

function my_public_ip () {
	wget -qO- ifconfig.co ||
	wget -qO- ifconfig.me ||
	wget -qO- icanhazip.com ||
	dig +short myip.opendns.com @resolver1.opendns.com
}

# http://stackoverflow.com/questions/1058047/wait-for-any-process-to-finish
function my_wait_pid() {
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

function iniciar_funcoesZZ () {
	# Instalacao das Funcoes ZZ (www.funcoeszz.net)
	export ZZOFF=""  # desligue funcoes indesejadas
	export ZZPATH="~/outros/softwares/gnu+linux/funcoeszz/funcoeszz"  # script
	export ZZDIR="~/outros/softwares/gnu+linux/funcoeszz/zz"
	source "$ZZPATH"
}

function definir_proxy () {
	if [[ -z $1 ]]; then
		echo "Uso: definir_proxy servidor porta usuario senha"
		return 1
	fi
	P_SERVIDOR=$1
	P_PORTA=$2
	P_USUARIO=$3
	P_SENHA=$4
	export http_proxy=http://${P_SERVIDOR}:${P_PORTA}
	export https_proxy=https://${P_SERVIDOR}:${P_PORTA}
}

function show_cowsay_fortune () {
	# Exibe uma frase dita por um 'treco' aleatorio
	# No debian jessie/testing:
	# apt-get install cowsay fortune-mod fortunes-br
	# parece que nao encontra as mensagens se houver mais de um pacote instalado
	# apt-get install cowsay fortunes-br fortunes-debian-hints
	# apt-cache search fortunes para ver as outras opcoes
	# Nota: o código rodou de primeira \o/
	# http://en.wikipedia.org/wiki/Fortune_%28Unix%29
	# http://en.wikipedia.org/wiki/Cowsay
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
show_calendar

#EOF
