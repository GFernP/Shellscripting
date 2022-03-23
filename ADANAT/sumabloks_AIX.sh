#!/usr/bin/bash

dbid=$1
pathlogs=/home/dba02/logs
adarep db=$dbid summary > $pathlogs/totalcontains.log
contain=$2
numcont=`cat $pathlogs/totalcontains.log|grep -c " $contain"`
smblocka=0
smblockb=0
smblockc=0
i=1
#for [ i=1; i <= $numcont; i++ ]
while [ $i -le $numcont ]
do  
    blocksize=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $6}'|awk -F "," '{print $1}'`
    if [ $blocksize -eq 8 ]
    then
        sumblocka=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $5}'|sed 's:[^0-9]::g'`
        smblocka=`expr $smblocka + $sumblocka`
        totdata[0]=$smblocka
        regbksize[0]=$blocksize
    elif [ $blocksize -eq 16 ]
    then
        sumblockb=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $5}'|sed 's:[^0-9]::g'`
        smblockb=`expr $smblockb + $sumblockb`
        totdata[1]=$smblockb
        regbksize[1]=$blocksize
    elif [ $blocksize -eq 32 ]
    then
        sumblockc=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $5}'|sed 's:[^0-9]::g'`
        smblockc=`expr $smblockc + $sumblockc`
        totdata[2]=$smblockc
        regbksize[2]=$blocksize
    fi
	i=`expr $i + 1` 
done

#for (( i=0; i <= 2; i++ ))
for i in 0 1 2
do
    if [[ -z ${totdata[$i]} ]]
    then
	if [[ -z ${regbksize[$i]} ]]
	then
        	echo "Datos no encontrados" > /dev/null
    	fi
    else
    	echo "$contain ${regbksize[$i]}K total de bloques: ${totdata[$i]}"
    fi
done
