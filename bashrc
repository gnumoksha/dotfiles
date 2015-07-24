#!/bin/bash
# By Tobias Sette. Public domain.
#
# 11/09/14 - primeira versão destas rotinas em um único arquivo separado

###################################
#              CORES              #
###################################
#TODO melhorar esta parte. Evitar poluir o ambiente com variaveis
export TERM=xterm-256color

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi


	# http://bashscript.blogspot.com/2010/01/shell-colors-colorizing-shell-scripts.html
	zera="\[\033[00m\]"
	zera2="\033[00m"
	bold="\[\033[01;34m\]"
	sublinhado="\[\033[00;4m\]"
	red="\[\033[00;31m\]"
	red2="\033[00;31m"
	green="\[\033[00;32m\]"
	green2="\033[00;32m"
	# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
	#PROMPT_COMMAND='
	#RET=$?;
	#if [[ $RET -eq 0 ]]; then
#		echo -ne "${green2}$RET${zera2}";
	#else
#		echo -ne "${red2}$RET${zera2}";
	#fi;
	#echo -n " "'

	#PS1="${debian_chroot:+($debian_chroot)}${bold}\u${zera}@${sublinhado}\h${zera}:\w\$ "
	#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# https://www.ibm.com/developerworks/community/blogs/752a690f-8e93-4948-b7a3-c060117e8665/entry/prompt_de_bash_mais__c3_batil46?lang=en
cor_preto="\[\033[00;30m\]"
cor_azul="\[\033[00;34m\]"
cor_verde="\[\033[00;32m\]"
cor_ciano="\[\033[00;36m\]"
cor_vermelho="\[\033[00;31m\]"
cor_roxo="\[\033[00;35m\]"
cor_marrom="\[\033[00;33m\]"
cor_cinza_claro="\[\033[00;37m\]"
cor_cinza_escuro="\[\033[01;30m\]"
cor_azul_claro="\[\033[01;34m\]"
cor_verde_claro="\[\033[01;32m\]"
cor_ciano_claro="\[\033[01;36m\]"
cor_vermelho_claro="\[\033[01;31m\]"
cor_roxo_claro="\[\033[01;35m\]"
cor_amarelo="\[\033[01;33m\]"
cor_branco="\[\033[01;37m\]"
cor_nenhum="\[\033[00m\]"
cor_amarelo_fundo_vermelho="\[\033[01;33;41m\]"
sublinhado="\[\033[00;4m\]"

#if [[ ${UEID} == 0 ]]; then
#if [[ $(whoami) == "root" ]]; then
if [[ $EUID -eq 0 ]]; then
	# para root
	export PS1="${cor_marrom}\t ${cor_amarelo_fundo_vermelho}\u${cor_marrom}@${cor_verde_claro}\h${cor_nenhum}:\w# "
else
	export PS1="${cor_marrom}\t ${cor_azul_claro}\u${cor_marrom}@${cor_verde_claro}\h${cor_nenhum}:\w\$ "
fi

# http://www.cyberciti.biz/open-source/command-line-hacks/remark-command-regex-markup-examples/
REMARK=$(which remark)
if [[ ! -f $REMARK ]]; then
	echo "Instale o remark para habilitar destaque de sintaxe"
	echo "http://savannah.nongnu.org/download/regex-markup/"
else
	ping_() { /bin/ping $@ | $REMARK /usr/share/regex-markup/ping; }
	traceroute_() { /usr/sbin/traceroute $@ | $REMARK /usr/share/regex-markup/traceroute; }
	diff_() { /usr/bin/diff $@ | $REMARK /usr/share/regex-markup/diff; }
fi

# http://www.cyberciti.biz/programming/color-terminal-highlighter-for-diff-files/
#alias diff="colordiff"


###################################
#            HISTÓRICO            #
###################################

#history -a
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000


###################################
#               PATH              #
###################################

# Para o debian
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/games"
# PHP composer
export PATH="$PATH:/home/tobias/.composer/vendor/bin"
# Binarios extras sem instalador para debian
export PATH="$PATH:/home/tobias/outros/softwares/gnu+linux/bin"

###################################
#             ALIASES             #
###################################

alias screen_logs="sudo screen -c ~/.screen_para_logs"
alias meu_ip="wget -q -O - ip.appspot.com"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -I'
alias dmesg="dmesg -T" # exibe data/hora em formato humano
# necessario pacote trash-cli
# Documentacao: https://github.com/andreafrancia/trash-cli
alias lixeira_enviar="trash-put"
alias lixeira_listar="trash-list"
alias lixeira_restaurar="trash-restore"
alias lixeira_esvaziar="trash-empty"
alias lixeira_apagar="trash-rm"


###################################
#             FUNÇÕES             #
###################################

entrar_no_env () {
	#TODO criar um autocomplete com TAB
	env=$1
	diretorio='/home/tobias/play/python/'
	if [[ -z $env ]]; then
		echo "Uso: entrar_no_env 'dir'
Onde 'dir' estah dentro de '$diretorio' e dentro dele ha um
ambiente virtual chamado env"
	return 1
	fi
	cd "${diretorio}/${env}"
	if [[ $? -eq 0 ]]; then
		source env/bin/activate
	fi
}

entrar_no_projeto () {
	#TODO criar um autocomplete com TAB
	linguagem=$1
	nome=$2
	diretorio='/home/tobias/play/'
	if [[ -z $linguagem ]]; then
		echo "Uso: entrar_no_projeto 'linguagem' 'nome'
Onde 'linguagem' e 'nome' estao dentro de '$diretorio'"
		return 1
	fi
	cd "${diretorio}/${linguagem}/"
	cd "${nome}"
}

iniciar_funcoesZZ () {
	# Instalacao das Funcoes ZZ (www.funcoeszz.net)
	export ZZOFF=""  # desligue funcoes indesejadas
	export ZZPATH="/home/tobias/outros/softwares/gnu+linux/funcoeszz/funcoeszz"  # script
	export ZZDIR="/home/tobias/outros/softwares/gnu+linux/funcoeszz/zz"
	source "$ZZPATH"
}

definir_proxy () {
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

exibir_fortune () {
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
	if [ "$fraseFortune" == '' ]; then
		fraseFortune=$($programaFortune /usr/share/games/fortunes/ 2>/dev/null)
	fi

	if [ "$fraseFortune" == '' ]; then
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


function exibir_calendario () {
	CALENDAR=$(which calendar 2> /dev/null)
	ARQUIVO_CALENDAR=~/.calendar/calendar
	CONTEUDO_ARQUIVO_CALENDAR=$( cat<<EOF
// ls /usr/share/calendar/
// alguns dos arquivo do man calendar nao existem
LANG=pt_BR.UTF-8

#include <calendar.birthday>
#include <calendar.computer>
//#include <calendar.fictional>																																				  
#include <calendar.lotr>
#include <calendar.debian>
#include <calendar.ubuntu>
#include <calendar.history>
#include <calendar.music>
//#include <calendar.space>
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
		$CALENDAR -A 0
		echo "--------------------------------------------------------------------------------"
	fi
}

# http://stackoverflow.com/questions/1058047/wait-for-any-process-to-finish
aguardar_pid() {
	for pid in "$@"; do
		while kill -0 "$pid"; do
			sleep 0.5
		done
	done
}

# http://superuser.com/questions/247564/is-there-a-way-for-one-ssh-config-file-to-include-another-one
# http://www.linuxsysadmintutorials.com/multiple-ssh-client-configuration-files/
# #FIXME essa condicao sempre será verdadeira?
if [[ $(ls ~/.ssh/*.config 2>/dev/null) ]]; then
	rm ~/.ssh/config 2>/dev/null
	for arquivo_ssh in $(ls ~/.ssh/*.config); do
		cat $arquivo_ssh >> ~/.ssh/config
	done
fi
ssh_add_wrapper() {
	ssh-add ~/.ssh/id_rsa-2048
	ssh-add ~/.ssh/id_rsa-git
}

exibir_fortune
exibir_calendario

#TODO criar uma funcao para verificar se pacotes necessarios estao instalados

#EOF
