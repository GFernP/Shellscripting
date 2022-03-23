#!/bin/bash
##by GFP 01/06/16

fecha=`date +%y%m%d_%H%M%S`

echo -e "#### SNAPSHOT DE PROCESOS Y BASE DE DATOS #### \n" > /home/dba02/logs/SNAPSHOT_$fecha.log

echo -e "**** Top de procesos por consumo de memoria ****\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log
#sudo svmon -Pt15 | perl -e 'while(<>){print if($.==2||$&&&!$s++);$.=0 if(/^-+$/)}' >> /home/dba02/logs/SNAPSHOT_$fecha.log
ps -fea -o ruser,pid,cpu,rssize,vsz,args |head -1 >> /home/dba02/logs/SNAPSHOT_$fecha.log
ps -fea -o ruser,pid,cpu,rssize,vsz,args |sort -k 4rn|head >> /home/dba02/logs/SNAPSHOT_$fecha.log
echo -e "\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log

echo -e "**** Top de procesos por consumo de CPU ****\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log
ps -Af |head -1 >> /home/dba02/logs/SNAPSHOT_$fecha.log
ps -fea |grep -v UID | awk ' $4>"'10'" { print $0 } '| sort -k 4rn >> /home/dba02/logs/SNAPSHOT_$fecha.log
echo -e "\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log

echo -e "**** Highwater Base de Datos ****\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log
adaopr db=4 display=high >> /home/dba02/logs/SNAPSHOT_$fecha.log
echo -e "\n" >> /home/dba02/logs/SNAPSHOT_$fecha.log
