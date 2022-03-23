#!/usr/bin/bash

dbid=$1
pathlogs=/opt/sag2/logs
adarep db=$dbid free_space > $pathlogs/freecontains.log
contain=$2  #contenedor puede ser ASSO o DATA
numpat=`cat $pathlogs/freecontains.log |grep -n $contain|awk -F ":" '{print $1}'`
countl=`cat $pathlogs/freecontains.log |wc -l`
sumbloc=0
x=1
#cat freecontains.log |while read line
while [ $numpat -lt $countl ] 
    do 
        numpat=`expr $numpat + 1`
        linea=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $1}'`
        if [ -z $linea ]
        then 
            echo "linea vacia" >/dev/null
            numpat=$countl
        elif [ $linea -eq $x ]
        then
            bloque=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $4}'|sed 's:[^0-9]::g'`
            sumbloc=`expr $sumbloc + $bloque`
        else
            y=`expr $x - 1`
            totdata[$y]=$sumbloc
            sumbloc=0
            x=`expr $x + 1`
            bloque=`cat $pathlogs/freecontains.log|sed -n "$numpat"p|awk '{print $4}'|sed 's:[^0-9]::g'`
            sumbloc=`expr $sumbloc + $bloque`

        fi
    done
y=`expr $x - 1`
totdata[$y]=$sumbloc
num=0
for (( i=0; i <= $y; i++ ))
do
    num=`expr $num + 1`
    echo "$contain$num Util: ${totdata[$i]}" >> $pathlogs/statsdb$dbid.log
done