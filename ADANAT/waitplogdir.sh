#!/usr/bin/bash

dirplog=/imagenesPDA/testadabas/aprocesar
serie=$1
numplog=$2
fecha=$(date +%Y%m%d)
historec=/imagenesPDA/testadabas/historec_list_$fecha.log

while true
do
    if [ -f "$dirplog/NUCPLG.$serie($numplog)" ]
    then
	horaini=$(date +%H:%M:%S)
	echo "$fecha,$horaini,archivo NUCPLG.$serie($numplog) existe en directorio, proceso continua" >> $historec
        exit
    else
        sleep 3
    fi
done
