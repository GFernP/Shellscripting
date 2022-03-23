#!/usr/bin/bash

year=$1
file=/home/sag/codenvios.txt
fsalida=/RespHistorico/solicitud200528/codenvios$year.txt
ferr=/RespHistorico/solicitud200528/err_codenvios$year.txt

for i in `ls $year/`
do
    gunzip $year/$i
    txtfi=$(echo $i |awk -F "." '{ print $1"."$2}')
    echo "busqueda en archivo $i" >> $fsalida
    #cat $i |grep -f $file >> $fsalida 2>> $ferr
    cat $txtfi |grep -f $file >> $fsalida
    gzip $txtfi
done
RC=$?
#grep -f $file `find $year/SEEN_34_* -type f -print` >> $fsalida 2>> $ferr
fecha=`date`
echo "proceso terminado $fecha" >> $fsalida

# if [ $RC -gt 0 ]
# then
#     echo "proceso termino con fallas, ver archivo $ferr" |mail -s "error proceso de busqueda" german.fernandez@softwareag.com
# else
    echo "Proceso terminado ok ver archivo $fsalida" |mail -s "Proceo de busqueda terminado OK" german.fernandez@softwareag.com
# fi