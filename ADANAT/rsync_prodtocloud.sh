#!/bin/bash
###Rsync de objetos Natural Fuser30 y  NJX de Produccion.
##by GFP 15/05/2018

fch=`date  '+%d.%m.20%y %H:%M:%S'`
logrt=/respaldo/logs/rsync_prod_to_dev.log
echo "################################################################ $fch " >> $logrt
echo "################################################################ " >> $logrt
date >> $logrt
echo "NAT_Fuser30:" >> $logrt
rsync -avc  --exclude=.svn/* sag3@10.150.156.80:/opt/sagSisve3/fuser30 /respaldo/produccion/natfuser30 >> $logrt

echo "################################################################  " >> $logrt

date >> $logrt
echo "Sisve30v3:" >> $logrt
rsync -avc  --exclude=.svn/* sisve@10.150.156.93:/usr/local/wildfly-9/standalone/deployments/SISVE30v3.war/ /respaldo/produccion/njxSISVE30v3 >> $logrt

fch=`date  '+%d.%m.20%y %H:%M:%S'`
echo "***************************************************************************************************************************************** $fch " >> $logrt

fch=`date  '+%d.%m.20%y %H:%M:%S'`
logrc=/respaldo/logs/rsync_dprod_to_cloudbck.log
echo "################################################################ $fch " >> $logrc
echo "################################################################ " >> $logrc
date >> $logrc
echo "NAT_Fuser30:" >> $logrc
rsync -avc /respaldo/produccion/natfuser30 sag@190.196.218.6:/respaldo/PROD/NAT/ >> $logrc

echo "################################################################  " >> $logrc

date >> $logrc
echo "Sisve30v3:" >> $logrc
rsync -avc /respaldo/produccion/njxSISVE30v3 sag@190.196.218.6:/respaldo/PROD/NJX/SISVE30v3/ >> $logrc

fch=`date  '+%d.%m.20%y %H:%M:%S'`
echo "***************************************************************************************************************************************** $fch " >> $logrc