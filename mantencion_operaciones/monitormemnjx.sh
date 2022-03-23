#!/bin/bash
Fecha=`date +%Y%m%d_%H%M%S`
ssh sisve@10.150.156.71 "export TERM=xterm; free |grep Mem" > /home/dba02/logs/vta01mem.log
ssh sisve@10.150.156.72 "export TERM=xterm; free |grep Mem" > /home/dba02/logs/vta02mem.log
ssh sisve@10.150.156.73 "export TERM=xterm; free |grep Mem" > /home/dba02/logs/vta03mem.log
ssh sisve@10.150.156.74 "export TERM=xterm; free |grep Mem" > /home/dba02/logs/vta04mem.log
echo "#################################################" >> /home/dba02/logs/MemoriaLinux.log
echo $Fecha >> /home/dba02/logs/MemoriaLinux.log
for i in `ls /home/dba02/logs/vta0*`
do
total=`cat $i| awk '{print $2}'`
porcent=100
used=`cat $i|awk '{print $3}'`
multi=`expr $used \* $porcent`
name=`ls $i | cut -c 18-22`
prd=`expr $multi / $total`
if [ $prd -ge 85 ]
then
	echo "Warning: $prd% de memoria utilizada en $name"| mail -s "Warning de utilizacion de memoria" german.fernandez@softwareag.com -c germanfernandez.p@gmail.com
	echo "$prd% de memoria  utilizada en $name" >> /home/dba02/logs/MemoriaLinux.log

else
	echo "$prd% de memoria  utilizada en $name" >> /home/dba02/logs/MemoriaLinux.log

fi
done
