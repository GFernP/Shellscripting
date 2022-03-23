#!/usr/bin/bash

dirwork=/imagenesPDA/testadabas

dbid=$1

dirlogs=$dirwork/logs
fecha=$(date +%Y%m%d)
horaini=$(date +%H:%M:%S)
explog=$dirlogs/outexp_$fecha.log
historec=$dirlogs/historec_list_$fecha.log

cd $dirwork

calclog ()
{
horafin=$(date +%H:%M:%S)
seg1=$(echo $horaini | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
seg2=$(echo $horafin | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
tiempo=$(expr $seg2 - $seg1)
}

for i in 93 94 95 
do
	mv $dirwork/NUCPLG.00$i* $dirwork/aprocesar
        sh adarec_expect_serie.sh 20 00$i
        msg=$(tail -1 $dirlogs/lastatlist_20220111.log)
        if `echo $msg|grep -q "ABORTED"`
        then
	calclog
	echo "$fecha,$horaini,$horafin,$tiempo,adarec termina con fallas en regeneracion plog $plog" >> $historec
	exit
	elif `echo $msg|grep -q "TERMINATED"`
	then
	calclog
	echo "$fecha,$horaini,$horafin,$tiempo,adarec puede continuar" >> $historec
	fi
done
