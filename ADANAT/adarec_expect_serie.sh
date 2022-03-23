#!/usr/bin/bash

. /home/sag/.profile >/dev/null 2>&1
#serie=$(ls -t /PLOG/aprocesar/plog.* |head -1 |awk -F "." '{print $2}' |awk -F "(" '{print $1}')
dbid=$1
serie=$2
fecha=$(date +%Y%m%d)
horaini=$(date +%H:%M:%S)
dirwork=/imagenesPDA/testadabas
. $dirwork/setrecplg.sh $serie
dirlogs=$dirwork/logs
statrec=$dirlogs/lastatlist_$fecha.log
historec=$dirlogs/historec_list_$fecha.log

echo "#######################################################" >> $statrec
echo "$fecha,$horaini, Inicio adarec regeneracion" >> $historec

adarec db=$dbid regenerate=*,plog=$serie,error_log,on_error=abort |tee -a $statrec

horafin=$(date +%H:%M:%S)
seg1=$(echo $horaini | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
seg2=$(echo $horafin | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
tiempo=$(expr $seg2 - $seg1)
echo "$fecha,$horaini,$horafin,$tiempo,lista plog $serie finaliza revisar log $statrec" >> $historec
mv $dirwork/aprocesar/NUCPLG.$serie* $dirwork/procesados/
