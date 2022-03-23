#!/usr/bin/bash

#Para ver las colas de usuario Adabas pegadas (que no tienen pid existente)
#ejecutar con id de usuario (sag, sisve, node1, node2, node3, node4)
user=$1
tiempo=$(date +%Y%m%d_%H%M)
for i in `adaopr db=4 display=uq |awk '$3=="'$user'" {print $4}'`
do
    count=$(ps -Af |grep -v grep |grep -c $i)
    RC=$?
    if [ $count -eq 0 ]
    then
        adaopr db=4 display=uq |grep $i >> /home/dba02/logs/uqnotfound_$tiempo.log
        uid=$(cat /home/dba02/logs/uqnotfound_$tiempo.log |grep $i|awk '{print $1}')
        adaopr db=4 stop=$uid
    fi
done