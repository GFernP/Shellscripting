#!/bin/bash
Monitor de proceso cada 5 minutos

fech=`date +%y%m%d_%H%M%S`
echo $1 > /home/dba02/logs/$1.log
proceso=`xargs < /home/dba02/logs/$1.log`
echo "########################################################################################################" > /home/dba02/logs/monprocess_$proceso_$fech.log
#echo "\n" >> /home/dba02/logs/monprocess_$proceso_$fech.log
echo "########################## Inicio log $fech #############################################" >> /home/dba02/logs/monprocess_$proceso_$fech.log
echo "########################################################################################################" >> /home/dba02/logs/monprocess_$proceso_$fech.log
intpro=`ps -Af |grep $proceso |grep -ve grep -e monprocess|wc -l`
if [ $intpro -gt 0 ]
then
        echo "El proceso $proceso se encuentra iniciado" |mail -s "Inicio de proceso $proceso" germanfernandez.p@gmail.com
fi

while true; do
        proceso=`xargs < /home/dba02/logs/$1.log`
        fpro=`ps -Af |grep $proceso |grep -ve grep -e monprocess`
        counpro=`ps -Af |grep $proceso |grep -ve grep -e monprocess|wc -l`
        bo=`date +%m/%d/%Y`
        do=`date +"%H:%M:%S"`
        echo $bo $do >> /home/dba02/logs/monprocess_$proceso_$fech.log
        echo $fpro >> /home/dba02/logs/monprocess_$proceso_$fech.log
        if [ $counpro -eq 0 ]
        then
                cd /home/dba02/logs/
                uuencode monprocess_$proceso_$fech.log monprocess_$proceso_$fech.log | mailx -s "Monitor proceso" german.fernandez@softwareag.com
                exit
        fi
        echo "----------------------------------------------------------------" >> /home/dba02/logs/monprocess_$proceso_$fech.log
        sleep 300
done
