#!/usr/bin/env bash

show_calendar () {
	CALENDAR=$(command -v calendar 2> /dev/null)
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
if [[ -n $procura ]]; then
	return 0
else
	mktemp --suffix=bu_calendar > /dev/null 2>&1
fi

if [[ -z "${CALENDAR}" ]]; then
	echo "Aplicativo calendar não encontrado"
else
	if [ ! -f ${ARQUIVO_CALENDAR} ]; then
		echo "Criando arquivo calendar com conteúdo padrão."
		# cria diretório
		mkdir -p "$(dirname "${ARQUIVO_CALENDAR}")"
		# cria arquivo
		echo "$CONTEUDO_ARQUIVO_CALENDAR" > "${ARQUIVO_CALENDAR}"
	fi

		# por fim, chama o calendar exibindo apenas os eventos para a data atual
		echo "--------------------------------------------------------------------------------"
		$CALENDAR -A 1
		echo "--------------------------------------------------------------------------------"
	fi
}

