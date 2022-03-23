#!/bin/bash

. /home/sag/.profile > /dev/null

log=/home/dba02/logs/sizefiles_db04.log
fecha=`date +%y%m%d_%H%M%S`
echo $fecha >> $log
echo "\n" >> $log
adarep db=4 file=20-200 | grep  "Records loaded:" |awk ' {print $0}'| sed 's:[^0123456789]::g' >> $log
echo "*****************************************************************************************" >> $log
