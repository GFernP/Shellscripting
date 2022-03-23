#!/usr/bin/bash

dirwork=/imagenesPDA/testadabas

dbid=20
#plog=$2
plog=$(ls -t aprocesar/NUCPLG.* |head -1 |awk -F "." '{print $2}' |awk -F "(" '{print $1}')
fixnplog=$(echo "plog"|sed 's/^0*//')
dirlogs=$dirwork/logs
fecha=$(date +%Y%m%d)
horaini=$(date +%H:%M:%S)
explog=$dirlogs/outexp_$fecha.log
historec=$dirlogs/historec_list_$fecha.log

cd $dirwork

./script.exp $dbid $plog $fixnplog > $explog

horafin=$(date +%H:%M:%S)
seg1=$(echo $horaini | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
seg2=$(echo $horafin | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
tiempo=$(expr $seg2 - $seg1)
echo "$fecha,$horaini,$horafin,$tiempo,script expect plog $plog finaliza revisar $explog" >> $historec
