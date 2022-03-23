#!/usr/bin/bash

pathlog=/opt/sisve/Shell/Logs
cd $pathlog
for i in `ls cotizaIP_head_2104*`
do
    cat $i |grep -v IP | while read line
    do
    fechfile=$(echo $i |awk -F "_" '{print $3}'|cut -c 1-6)
    hourfile=$(echo $i |awk -F "_" '{print $3}'|cut -c 7,8)
    sepcoma=$(echo $line |awk '{print $1","$2}' )
    echo "$fechfile,$hourfile,$sepcoma" >> $pathlog/consolidado_conexiones_wpcotiza.csv
    done
done

