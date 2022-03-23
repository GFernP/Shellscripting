#!/usr/bin/bash
#creador de directorios
#con subdirectorios de año y fecha yyyy/mm/d.

dirparent=$1
y=2020

cd $dirparent

while [ $y -le 2050 ]
do
m=1
    while [ $m -le 12 ]
    do
        if [ $m -ge 10 ]
        then
            for i in `cal $m $y`
            do
                cchar=`echo $i |wc -m`
                if [ $cchar -eq 3 ]
                then
                    mkdir -p $y/$m/$i
                elif [ $cchar -eq 2 ]
                then
                    mkdir -p $y/$m/0$i
                fi
            done
        else
            for i in `cal $m $y`
            do
                cchar=`echo $i |wc -m`
                if [ $cchar -eq 3 ]
                then
                    mkdir -p $y/0$m/$i
                elif [ $cchar -eq 2 ]
                then
                    mkdir -p $y/0$m/0$i
                fi
            done
        fi
    m=`expr $m + 1`
    done
y=`expr $y + 1`
done
