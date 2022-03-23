#!/usr/bin/bash


#captador de ip, iata y usuario

DIRLOG=/opt/sisve/Shell/Logs
tiempo=$(date +%D_%T)
patron="SISVE302 SISVE303 SISVE304"


for i in `echo $patron`
do
    tmpfile=$DIRLOG/procenwotmp.log
    file=$DIRLOG/procenwo_$i.log
    ps -Af |grep "nwo.sh" |grep $i |awk '{print $10,$17,$19}' > $tmpfile
    cat $tmpfile |
    while read line
    do
        ip=$(echo $line |awk '{print $1}')
        parm=$(echo $line |awk '{print $2}')
        iata=$(echo $line |awk -F "/" '{print $2}')
        id=$(echo $line |awk -F "/" '{print $3}')
        reg=$(echo $ip,$parm,$iata,$id)
        rep=$(grep -c $reg $file)
        if [ $rep -eq 0 ]
        then
            echo "$tiempo,$ip,$parm,$iata,$id" >> $file
        fi
    done
done

/opt/sisve/Shell/monitoreo/nwomon.sh
