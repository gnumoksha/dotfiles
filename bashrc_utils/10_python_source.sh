#!/bin/bash
# By Tobias Sette. Public domain.

entrarNoEnv () {
	env=$1
	diretorio='/home/tobias/play/python/'
	if [[ -z $env ]]; then
		echo "Uso: entrarNoEnv 'dir'
	Onde 'dir' estah dentro de '$diretorio' e dentro dele ha um
	ambiente virtual chamado env"
	exit 1
	fi
	cd "${diretorio}/${env}"
	if [[ $? -eq 0 ]]; then
		source env/bin/activate
	fi
}
