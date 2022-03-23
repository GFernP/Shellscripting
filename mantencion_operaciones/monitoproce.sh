#!/usr/bin/bash


#monitor proceso online SVCGCFA1 cada 1 minuto con loop de 10 segundos

proceso=$1
fecha=`date +%Y%m%d`
dirlog=/opt/sisve/Shell/Logs
x=0
while [ $x -lt 6 ]
do
ftime=`date +%T_%D`
countproc=`ps -Af |grep -i $proceso |wc -l`
echo "$ftime|$proceso|$countproc" >> $dirlog/procesotrack_$fecha.log
x=`expr $x + 1`
sleep 10
done
