#!/bin/bash

. /home/dba02/.profile > /dev/null

fecha=`date +%y%m%d_%H%M%S`
log=$HOME/logs/repliqueue.log
pend=`adaopr db=4 display=repli |grep -i pending`

echo " Transacciones de replicacion pendientes: " >> $log
echo "-----------------------------------------" >> $log
echo $pend >> $log
echo "\n" >> $log
echo $fecha >> $log
echo "******************************************" >> $log
echo "\n" >> $log
