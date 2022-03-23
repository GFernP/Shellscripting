#!/usr/bin/bash

dbid=$1
pathlogs=/opt/sag2/logs
adarep db=$dbid free_space > $pathlogs/freecontains.log
contain=$2  #contenedor puede ser ASSO o DATA
numpat=`cat $pathlogs/freecontains.log |grep -n $contain|awk -F ":" '{print $1}'`
countl=`cat $pathlogs/freecontains.log |wc -l`
smblocka=0
smblockb=0
smblockc=0
#cat freecontains.log |while read line
while [ $numpat -lt $countl ] 
    do 
        numpat=`expr $numpat + 1`
        linea=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $1}'`
        if [ -z $linea ]
        then 
            echo "linea vacia" >/dev/null
            numpat=$countl
        else
            blocksize=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $5}'|awk -F "," '{print $1}'`
            if [ $blocksize -eq 8 ]
            then
                sumblocka=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $4}'|sed 's:[^0-9]::g'`
                smblocka=`expr $smblocka + $sumblocka`
                totdata[0]=$smblocka
                regbksize[0]=$blocksize
            elif [ $blocksize -eq 16 ]
            then
                sumblockb=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $4}'|sed 's:[^0-9]::g'`
                smblockb=`expr $smblockb + $sumblockb`
                totdata[1]=$smblockb
                regbksize[1]=$blocksize
            elif [ $blocksize -eq 32 ]
            then
                sumblockc=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $4}'|sed 's:[^0-9]::g'`
                smblockc=`expr $smblockc + $sumblockc`
                totdata[2]=$smblockc
                regbksize[2]=$blocksize
            fi
        fi
    done
for (( i=0; i <= 2; i++ ))
do
    if [ -z ${totdata[$i]} ] && [ -z ${regbksize[$i]} ]
    then
        echo "Datos no encontrados" > /dev/null
    else
    echo "$contain ${regbksize[$i]}K total de bloques libres: ${totdata[$i]}"
    fi
done