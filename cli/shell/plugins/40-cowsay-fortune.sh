#!/usr/bin/env bash
# shellcheck disable=SC2012,SC2116,SC2045,SC2004,SC2086,SC2086

show_cowsay_fortune () {
	# Show fortune messages with a random cowsay character.
	# apt install fortunes-mod fortunes fortune-anarchism fortunes-br fortunes-debian-hints
	# fortunes-it fortunes-it-off fortunes-mario
	# Nota: o código rodou de primeira \o/
	# http://en.wikipedia.org/wiki/Fortune_%28Unix%29
	# http://en.wikipedia.org/wiki/Cowsay

	# Para que o fortune apareça apenas uma vez por dia
	procura=$(find /tmp -maxdepth 1 -mtime -1 -iname "*custom_fortune" -type f 2>/dev/null)
	if [[ -n $procura ]]; then
		return 0
	else
		mktemp --suffix=custom_fortune > /dev/null 2>&1
	fi

	[[ -n $TMUX ]] && return 0
	[[ $(whoami) == "root" ]] && return 0
	programaFortune="$(command -v fortune)"
	fraseFortune=''
	if [ -f "$programaFortune" ]; then
		fraseFortune=$($programaFortune 2>/dev/null)
	fi
	# Para quando houver mais de um pacote fortune instalado
	if [[ "$fraseFortune" == '' ]]; then
		fraseFortune=$($programaFortune /usr/share/games/fortunes/ 2>/dev/null)
	fi

	if [[ "$fraseFortune" == '' ]]; then
		fraseFortune=$(hostname)
	fi
	programaCowSay="$(command -v cowsay)"
	if [ -f "$programaCowSay" ]; then
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

