#/usr/bin/bash

#name=$(ls -t /PLOG/aprocesar/plog.* |head -1 |awk -F "." '{print $2}' |awk -F "(" '{print $1}')
name=$1
dirplog=/imagenesPDA/testadabas/aprocesar
fecha=$(date +%Y%m%d)
export RECPLG=$dirplog/NUCPLG.$name"(1)"
export RECERR=$dirplog/OUTPLG.ERR
#env |grep RECPLG
dirlogs=/imagenesPDA/testadabas/logs
historec=$dirlogs/historec_list_$fecha.log
i=2
limit=22
while [ "$i" -le $limit ]
do
export RECPLG$i=$dirplog/NUCPLG.$name"($i)"
#env |grep RECPLG$i
#unset RECPLG$i
#i=$(expr $i + 1)
var=$(env |grep -w RECPLG$i)
horaini=$(date +%H:%M:%S)
echo "$fecha,$horaini,variable $var seteada ok" >> $historec
let "i+=1"
done
