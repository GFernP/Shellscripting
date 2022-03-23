#!/bin/bash
#### Monitor de proceso cada 5 minutos

proceso=$1
fech=`date +%y%m%d_%H%M%S`
echo "########################################################################################################" > /home/dba02/logs/monprocess_$proceso_$fech.log
#echo "\n" >> /home/dba02/logs/monprocess_$proceso_$fech.log
echo "########################## Inicio log $fech #############################################" >> /home/dba02/logs/monprocess_$proceso_$fech.log
echo "########################################################################################################" >> /home/dba02/logs/monprocess_$proceso_$fech.log
while true; do
	fpro=`ps -Af |grep -w $proceso |grep -ve grep -e monprocess`
	counpro=`ps -Af |grep -w $proceso |grep -ve grep -e monprocess|wc -l`
	bo=`date +%m/%d/%Y`
	do=`date +"%H:%M:%S"`
	echo $bo $do >> /home/dba02/logs/monprocess_$proceso_$fech.log
	echo $fpro >> /home/dba02/logs/monprocess_$proceso_$fech.log
	if [ $counpro -eq 0 ]
        then
                cd /home/dba02/logs/
                uuencode monprocess_$proceso_$fech.log monprocess_$proceso_$fech.log | mailx -s "Monitor proceso" -r unimonsag@correos.cl german.fernandez@softwareag.com
                #uuencode monprocess_$proceso_$fech.log monprocess_$proceso_$fech.log | mailx -s "Monitor proceso" mesa.monitoreo@softwareag.com
		exit
        fi
	echo "----------------------------------------------------------------" >> /home/dba02/logs/monprocess_$proceso_$fech.log
	sleep 120
done
