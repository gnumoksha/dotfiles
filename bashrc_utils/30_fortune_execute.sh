#!/bin/bash
# By Tobias Sette. Public domain.

# 19/08/14 - Tobias - v0.1 rotina separada do .bashrc
# 25/08/14
#	adicionado rotina para verificar se o bash está rodando no tmux

# Exibe uma frase dita por um 'treco' aleatorio
# No debian jessie/testing:
# apt-get install cowsat fortune-mod fortunes-br
# parece que nao encontra as mensagens se houver mais de um pacote instalado
# apt-get install cowsay fortunes-br fortunes-debian-hints
# apt-cache search fortunes para ver as outras opcoes
# Nota: o código rodou de primeira \o/
# http://en.wikipedia.org/wiki/Fortune_%28Unix%29
# http://en.wikipedia.org/wiki/Cowsay
[[ -n $TMUX ]] && exit 0
programaFortune=$(which fortune)
fraseFortune=''
if [ -f $programaFortune ]; then
        fraseFortune=$($programaFortune)
fi
if [ "$fraseFortune" == '' ]; then
        fraseFortune=$(hostname)
fi
programaCowSay=$(which cowsay)
if [ -f $programaCowSay ]; then
        diretorioCows='/usr/share/cowsay/cows'
        numeroArquivosCow=$(ls -1 $diretorioCows | wc -l)
        # http://www.cyberciti.biz/faq/bash-shell-script-generating-random-numbers/
        numeroArquivoCowAleatorio=$( echo $((RANDOM%$numeroArquivosCow-1)) )
        numeroArquivoCowAtual=0
	#TODO usar array com indice numero ao inves do for
        for arquivoCow in $(ls $diretorioCows); do
                numeroArquivoCowAtual=$(($numeroArquivoCowAtual+1))
                if [ $numeroArquivoCowAtual -eq $numeroArquivoCowAleatorio ]; then
                        echo $fraseFortune | $programaCowSay -f $arquivoCow
                fi
        done
fi
