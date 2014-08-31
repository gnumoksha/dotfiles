#!/bin/bash
# By Tobias Sette. Public domain.

# Este arquivo é responsável por chamar os scripts de maneira correta


if [[ ! -z $1 ]]; then
	SCRIPTPATH=$1
else
	SCRIPTPATH=$(dirname $0)
fi

for arquivo in $(ls $SCRIPTPATH/*_source.sh); do
        source $arquivo
done

for arquivo in $(ls $SCRIPTPATH/*_execute.sh); do
        bash $arquivo
done




