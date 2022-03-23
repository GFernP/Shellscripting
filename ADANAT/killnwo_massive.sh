#!/bin/bash


ps -Af |grep sag3|grep nwo.sh |grep -v grep > $HOME/logs/nwosisve3.log

cat nwosisve3.log |awk '{print $5,$10}' > $HOME/logs/time_ip.log

cat time_ip.log |sort -k 1n > $HOME/logs/sortime.log

time=`date +%Y%m%d_%H%M%S`
echo "--------------------------------------------------------------" >> $HOME/logs/regkill.log
echo "Inicio pid kill $time : " $HOME/logs/regkill.log
head sortime.log |
while read line
do
    y=`echo $line |awk '{print $2}'`
    x=`ps -Af |grep $y |grep -v grep|wc -l`
    if [ $x -gt 2 ]
    then
        z=`echo $line |awk '{print $1}'`
        killi=`ps -Af |grep -v grep |grep nwo.sh |grep $y |grep $z|awk '{print $2}'`
        sudo kill -9 $killi
        echo "el proceso $killi ha sido eliminado" > $HOME/logs/regkill.log
    fi
    sleep 1
done


