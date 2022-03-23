#!/bin/bash


errlog=/opt/sisve/Shell/Logs/errortransbackup.log
cp /respaldo/db004bck/DB004.BCK /backup/fortrans/
fech=`date +%F_%T`
echo "$fech: se termina de copiar el respaldo a /backup/fortrans/" > /opt/sisve/Shell/Logs/tranferbackup.log
gzip /backup/fortrans/DB004.BCK
RC=$?
fech=`date +%F_%T`
if [ $RC -gt 0 ]
then
    echo "ERROR 1010 [$fech]: Error de compresion $RC" >> $errlog
    echo "ERROR 1010 [$fech]: Error de compresion $RC" |mail -s "ERROR COMPRESION BACKUP" german.fernandez@softwareag.com
    exit
fi
echo "$fech: se termina de comprimir el respaldo" >> /opt/sisve/Shell/Logs/tranferbackup.log
echo "------------------------------------------------------------------------------------------" >> /opt/sisve/Shell/Logs/tranferbackup.log
scp -Cv /backup/fortrans/DB004.BCK.gz sag@10.150.156.81:/respaldo/db004bck/ 2>> /opt/sisve/Shell/Logs/tranferbackup.log
RC=$?
fech=`date +%F_%T`
if [ $RC -gt 0 ]
then
    echo "ERROR 1020 [$fech]: Error de transferencia $RC" >> $errlog
    echo "ERROR 1020 [$fech]: Error de transferencia $RC" |mail -s "ERROR TRANSFERENCIA BACKUP" german.fernandez@softwareag.com
    exit
fi

echo "------------------------------------------------------------------------------------------" >> /opt/sisve/Shell/Logs/tranferbackup.log
echo "$fech: se termina de transferir el respaldo" >> /opt/sisve/Shell/Logs/tranferbackup.log

cat /opt/sisve/Shell/Logs/tranferbackup.log |mail -s "Archivo transferido a Contingencia" german.fernandez@softwareag.com




