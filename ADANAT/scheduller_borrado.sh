#!/bin/bash


echo "TABLA 21:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
time=`date +%Y%m%d_%H%M%S`
re21=`/opt/softwareag/Adabas/adarep dbid=4 file=21 |grep -i "records loaded"`
echo "$time: Registros antes del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo -e "\t $re21" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
shel1=ZDEL21IS.sh
cd /opt/sisve/demonio/
sh $shel1
RC=$?
if [ $RC -gt 0 ]
then
    time=`date +%Y%m%d_%H%M%S`
    echo "ERROR en proceso de borrado $shel1 #$RC, verificar los ultimos logs del proceso /opt/salida/ZDEL , corregir y ejecutar manualmente la shell /opt/sisve/demonio/$shel1 o esta shell" |mail -s "ERROR DE PROCESO DE BORRADO $shel1" mesa.monitoreo@softwareag.com
    echo "$time: ERROR en proceso de borrado $shel1 #$RC" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
    echo "*******************************************************" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
    exit
fi
time=`date +%Y%m%d_%H%M%S`
re21=`/opt/softwareag/Adabas/adarep dbid=4 file=21 |grep -i "records loaded"`
echo "$time: Registros despues del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo -e "\t $re21" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo "------------------------------------------------------------------------------" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo " " >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log

echo "TABLA 32:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
time=`date +%Y%m%d_%H%M%S`
re32=`/opt/softwareag/Adabas/adarep dbid=4 file=32 |grep -i "records loaded"`
echo "$time: Registros antes del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo -e "\t $re32" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
shel2=ZDEL32IS.sh
cd /opt/sisve/demonio/
sh $shel2
RC=$?
if [ $RC -gt 0 ]
then
    time=`date +%Y%m%d_%H%M%S`
    echo "ERROR en proceso de borrado $shel2 #$RC, verificar los ultimos logs del proceso /opt/salida/ZDEL , corregir y ejecutar manualmente la shell /opt/sisve/demonio/$shel2 o esta shell" |mail -s "ERROR DE PROCESO DE BORRADO $shel2" mesa.monitoreo@softwareag.com
    echo "$time: ERROR en proceso de borrado $shel2 #$RC" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
    echo "*******************************************************" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
    exit
fi
time=`date +%Y%m%d_%H%M%S`
re32=`/opt/softwareag/Adabas/adarep dbid=4 file=32 |grep -i "records loaded"`
echo "$time: Registros despues del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo -e "\t $re32" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo "------------------------------------------------------------------------------" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
echo " " >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log

while true
do
    y=`ps -Af |grep -v grep |grep -c ZDEL34`
    if [ $y -eq 0 ]
    then
        echo "TABLA 34:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        time=`date +%Y%m%d_%H%M%S`
        re34=`/opt/softwareag/Adabas/adarep dbid=4 file=34 |grep -i "records loaded"`
        echo "$time: Registros antes del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        echo -e "\t $re34" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        shel3=ZDEL34IS.sh
        cd /opt/sisve/demonio/
        sh $shel3
        RC=$?
        if [ $RC -gt 0 ]
        then
            echo "ERROR en proceso de borrado $shel3 #$RC, verificar los ultimos logs del proceso /opt/salida/ZDEL , corregir y ejecutar manualmente la shell /opt/sisve/demonio/$shel3 o esta shell" |mail -s "ERROR DE PROCESO DE BORRADO $shel3" mesa.monitoreo@softwareag.com
            echo "$time: ERROR en proceso de borrado $shel3 #$RC" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
            echo "*******************************************************" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
            exit
        fi
        time=`date +%Y%m%d_%H%M%S`
        re34=`/opt/softwareag/Adabas/adarep dbid=4 file=34 |grep -i "records loaded"`
        echo "$time: Registros despues del borrado:" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        echo -e "\t $re34" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        echo " " >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        echo "Procesos de borrado terminados, verificar salidas en /opt/salida/ZDEL" >> /opt/sisve/Shell/Logs/Borrado_Mayo2018.log
        cd /opt/sisve/Shell/Logs
        uuencode Borrado_Mayo2018.log Borrado_Mayo2018.log |mailx -s "Procesos de borrado terminados" mesa.monitoreo@softwareag.com
        exit
    fi
    sleep 60
done
