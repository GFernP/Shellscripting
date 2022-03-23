#!/bin/bash

. /home/dba02/.profile > /dev/null

fecha=`date +%y%m%d_%H%M%S`
log=$HOME/logs/sizedbsrepl.log
asso111=`adarep db=11 free |grep "8,192"|sed -n "1p"`
asso112=`adarep db=11 free |grep "8,192"|sed -n "2p"`
data11=`adarep db=11 free |grep "16,384"`
asso12=`adarep db=12 free |grep "8,192"`
data12=`adarep db=12 free |grep "16,384"`

echo " Espacio disponible databases: " >> $log
echo "******************************************" >> $log
echo "Base 11:" >> $log
echo $asso111 >> $log
echo $asso112 >> $log
echo $data11 >> $log
echo "-----------------------------------------" >> $log
echo "Base 12:" >> $log
echo $asso12 >> $log
echo $data12 >> $log
echo $fecha >> $log
echo "******************************************" >> $log
echo "\n" >> $log
