#!/usr/bin/bash

dbid=$1
pathlogs=/opt/sag2/logs
adarep db=$dbid summary > $pathlogs/totalcontains.log
contain=$2
numcont=`cat $pathlogs/totalcontains.log|grep -c " $contain"`
y=0
if [ $numcont -gt 2 ]
then
    for (( i=2; i <= $numcont; i++ ))
    do  
        x=`expr $i - 1`
        blocksizex=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$x"p|awk '{print $6}'|awk -F "," '{print $1}'`
        blocksizei=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $6}'|awk -F "," '{print $1}'`
        if [ $blocksizei -eq $blocksizex ]
        then
            sumblock=`cat $pathlogs/totalcontains.log|grep " $contain"|awk '{print $5}'|sed 's:[^0-9]::g'|awk '{sum += $1} END {print sum}'`
            totdata[$y]=$sumblock
            regbksize[$y]=$blocksizei
        else    
            if [ $i -eq 2 ]
            then
                sumblockx=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 1p|awk '{print $5}'|sed 's:[^0-9]::g'`
                totdata[$y]=$sumblockx
                regbksize[$y]=$blocksizex
                sumblocky=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 2p|awk '{print $5}'|sed 's:[^0-9]::g'`
                y=`expr $y + 1`
                totdata[$y]=$sumblocky
                regbksize[$y]=$blocksizei
            else
                sumblock=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $5}'|sed 's:[^0-9]::g'`
                y=`expr $y + 1`
                totdata[$y]=$sumblock
                regbksize[$y]=$blocksizei
            fi
        fi
    done
elif [ $numcont -eq 2 ]
then
    blocksizex=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 1p|awk '{print $6}'|awk -F "," '{print $1}'`
    blocksizei=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 2p|awk '{print $6}'|awk -F "," '{print $1}'`
    if [ $blocksizei -eq $blocksizex ]
    then
        sumblock=`cat $pathlogs/totalcontains.log|grep " $contain"|awk '{print $5}'|sed 's:[^0-9]::g'|awk '{sum += $1} END {print sum}'`
        totdata[$y]=$sumblock
    else
        sumblockx=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 1p|awk '{print $5}'|sed 's:[^0-9]::g'`
        totdata[$y]=$sumblockx
        sumblocky=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n 2p|awk '{print $5}'|sed 's:[^0-9]::g'`
        y=`expr $y + 1`
        totdata[$y]=$sumblocky
    fi
else
    blocksize=`cat $pathlogs/totalcontains.log|grep " $contain"|awk '{print $6}'|sed 's:[^0-9]::g'`
    numblocks=`cat $pathlogs/totalcontains.log|grep " $contain"|awk '{print $5}'|sed 's:[^0-9]::g'`
fi