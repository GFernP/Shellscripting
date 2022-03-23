#!/usr/bin/bash

dbid=$1
pathlogs=/opt/sag2/logs
adarep db=$dbid summary > $pathlogs/totalcontains.log
contain=$2
numcont=`cat $pathlogs/totalcontains.log|grep -c " $contain"`

for (( i=1; i <= $numcont; i++ ))
do
    totcont=`cat $pathlogs/totalcontains.log|grep " $contain"|sed -n "$i"p|awk '{print $5}'|sed 's:[^0-9]::g'`
    echo "$contain$i Total: $totcont" >> $pathlogs/statsdb$dbid.log
done
