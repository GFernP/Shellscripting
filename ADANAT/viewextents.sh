#!/usr/bin/bash

dirlog=/home/dba02/logs
fecha=$(date +%Y%m%d_%H%M)
#file=file_contents_$fecha.txt

adarep dbid=4 contents > $dirlog/file_contents_$fecha.txt
count=1
cat $dirlog/$file |
while read line
do
    c=1
    summ=0
    if [ $count -ge 12 ] && [ $count -le 199 ]
    then
        for i in $line
        do
            if [ $c -ge 6 ] && [ $c -le 9 ]
            then
                summ=`expr $summ + $i`
            elif [ $c -eq 1 ]
            then
                namefile=$i
            fi
        c=`expr $c + 1`
        done
        echo "$namefile extents $summ" >> $dirlog/file_extents_$fecha.txt
    fi
    count=`expr $count + 1`
done
