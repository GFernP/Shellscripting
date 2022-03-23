#!/usr/bin/bash

fileprod=$1
filedrp=$2
name=$(echo $fileprod |awk -F "." '{print $1}')
cat $fileprod|while read line
 do 
    object=$(echo $line |awk '{print $5}')
    permisos=$(echo $line |awk '{print $1}')
    owner=$(echo $line |awk '{print $2}')
    group=$(echo $line |awk '{print $3}')
    size=$(echo $line |awk '{print $4}')
    if $(grep -q $object $filedrp); then
        searchobj=$(grep $object $filedrp)
        permisos2=$(echo $searchobj |awk '{print $1}')
        owner2=$(echo $searchobj |awk '{print $2}')
        group2=$(echo $searchobj |awk '{print $3}')
        size2=$(echo $searchobj |awk '{print $4}')
        if [ "$permisos" != "$permisos2" ];then
        echo "$line, diferencia de permisos" >> resultado_$name.log; fi
        if [ "$owner" != "$owner2" ];then
        echo "$line, diferencia de owner" >> resultado_$name.log; fi
        if [ "$group" != "$group2" ];then
        echo "$line, diferencia de grupo" >> resultado_$name.log; fi
        if [ $size -ne $size2 ];then
        echo "$line, diferencia de tamaño" >> resultado_$name.log; fi
    else
    echo "$line, no esta en DRP" >> resultado_$name.log
    fi
done
