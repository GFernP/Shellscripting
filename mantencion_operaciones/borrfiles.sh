#!/bin/bash
#set -x
MES=$1
DIA=$1
YEAR=$2
DIR=$3
Fecha=`date +%Y%m%d_%H%M%S`
#Ejecutar shell ej: sh borrfiles.sh Jun 2014 /DatosSeg02/Marca-Historial
#opcion 1 con year, 2 con dia, opcion 3 por mes.

 
ls -l $DIR | awk ' $8=="'$YEAR'" {print $0} ' |awk ' $6=="'$MES'" {print $9} ' > $HOME/logs/fileborr_$Fecha.log
#ls -l $DIR |awk ' $6=="'$DIA'" {print $9} ' > $HOME/logs/fileborr_$Fecha.log
#ls -ltr $DIR |awk ' $7=="'$MES'" {print $9} ' > $HOME/logs/fileborr_$Fecha.log

sed "s/^/rm -f /g" $HOME/logs/fileborr_$Fecha.log > $HOME/logs/fileborr.sh

chmod +x  $HOME/logs/fileborr.sh

cd $DIR

sh $HOME/logs/fileborr.sh

rm -f $HOME/logs/fileborr.sh
