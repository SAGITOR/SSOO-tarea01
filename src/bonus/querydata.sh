#!/bin/bash

help() { echo "Modo de uso: $0 [-f <nombreArchivo.CSV>] [-N <Catidad de permisos a listar> (debe ser mayor 0)]" 1>&2; exit 1; }

while getopts ":f:N:" opt; do
    case "${opt}" in
        f )
            f=${OPTARG}
            ;;
        N )
            N=${OPTARG}
            ;;
        * )
            help
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${f}" ] || [ -z "${N}" ] || [ "${N}" -lt "1" ]; then
    help
fi

contador=1
shortFile=`LC_ALL=en_US.utf8 sort -t";" -k18 -n -r $f`
IFS=$'\n'
read -d '' -r -a lines <<< "$shortFile"
IFS=';'

for i in "${lines[@]}"
do
	read -a columnas <<< "$i"
	echo "============== AUTO $contador =============="
        echo "Marca: ${columnas[3]}"
        echo "Modelo: ${columnas[4]}"
        echo "Versión: ${columnas[5]}"
        echo "Año: ${columnas[1]}"
        echo "Tasación: ${columnas[16]}"
	echo "Valor Permiso: ${columnas[17]}"
	if [ "$contador" == "$N" ];then
		break
	fi
	((contador++)) 
done
