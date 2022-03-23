#!/bin/bash
#set -x
MES=$1
DIA=$1
YEAR=$2
DIR=$3
y=1
BCKDIR=/respaldo/tmpfiles
Fecha=`date +%Y%m%d_%H%M%S`
#Ejecutar shell ej: sh zipfiles.sh Jun 2014 /DatosSeg02/Marca-Historial
#En caso que la busqueda sea por dia ejecutar shell asi: sh zipfiles.sh 07 2015 /opt/sag/nat/v63101/tmp/
#Opcion 1 busqueda por year, opcion 2 busqueda por mes, opcion 3 busqueda por dia.

#ls -ltr $DIR | awk ' $8=="'$YEAR'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
#ls -ltr $DIR | awk ' $8=="'$YEAR'" {print $0} ' |awk ' $6=="'$MES'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
ls -ltr $DIR |awk ' $6=="'$MES'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
#ls -ltr $DIR |awk ' $6=="'$DIA'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
#ls -ltr $DIR |awk ' $7=="'$MES'" {print $9} ' > $HOME/logs/filezip_$Fecha.log

cd $DIR

tar -cf $BCKDIR/Backupfiles_$1$YEAR.tar -L $HOME/logs/filezip_$Fecha.log

gzip $BCKDIR/Backupfiles_$1$YEAR.tar

ls -l $BCKDIR/Backupfiles_$1$YEAR.tar.gz

#while [ $y -eq 1 ]

#do

#        echo "Desea eliminar los archivos listados que ya fueron respaldados? [s/n]"
#        read q
#        clear
#        if [ $q == s ]
#        then
#        sh $HOME/myscripts/borrfiles.sh $MES $YEAR $DIR
#                echo "Archivos Eliminados"
#        exit
#        fi
#
#        if [ $q == n ]
#        then
#                echo "exit"
#        exit
#        else
#                echo "Verifique las opciones de repuesta \n"
#                echo " s = si, n = no"
#                y=1
#        fi
#done

