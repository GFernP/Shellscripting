#!/usr/bin/bash
# Script Standart para ejecucion
# salida=/opt/salida
# CBAPMAIL.sh ###Nombre de la Shell
##########
#Codigo Para Desactivacion Masiva de Procesos
act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi
####Estadisticas Unimon SISVE
bi=`date +%m/%d/%Y`
di=`date +"%H:%M:%S"`
##########

PRG=CBAPMAIL #Nombre del programa Natural
fch=`date +%Y%m%d_%H%M%S`

. /home/sisve/.profile > /dev/null
a=`ls /opt/sisve/demonio/lockfile/$PRG.log`
if test "$a" = ""
then
  touch /opt/sisve/demonio/lockfile/$PRG.log
  cmsynin=/opt/salida/$PRG-cmd-$fch.txt            # Comando
  cmobjin=/opt/salida/$PRG-input-$fch.txt          # data para el PRGrama / input
  cmprint=/opt/salida/$PRG-output-$fch.txt         # salida
  cmprt01=/opt/salida/$PRG-report1-$fch.txt
  export WRKF1=/opt/salida/$PRG_WF1.txt  # as defined in natparm
  export WRKF3=/opt/salida/$PRG_WF3.txt  # as defined in natparm
  export WRKF4=/opt/salida/$PRG_WF4.txt
  CMWRK01=/opt/salida/$PRG-wrk01-$fch.txt
  salida=/opt/salida/$PRG-out-$fch.txt
  lib=BATCH
  echo "====================================================" > $salida
  echo "$PRG Fecha: $fch                     "    >> $salida
  echo "cmsynin=/opt/salida/$PRG-cmd-$fch.txt"    >> $salida
  echo "cmobjin=/opt/salida/$PRG-input-$fch.txt"  >> $salida
  echo "cmprint=/opt/salida/$PRG-output-$fch.txt" >> $salida
  echo "cmprt01=/opt/salida/$PRG-report1-$fch.txt" >> $salida
  echo "CMWRK01=/opt/salida/$PRG-wrk01-$fch.txt"  >> $salida
  echo "====================================================" >> $salida
#
        echo  "LOGON $lib\n$PRG \nFIN" > $cmsynin
  echo  " \n" > $cmobjin
echo 'BATCHAPP $BATCHAPP'
  natural batchmode bp=$BPAPP parm=$BATCHAPP etid=$$ cc=on cmsynin=$cmsynin cmobjin=$cmobjin CMPRT01=$cmprt01 cmprint=$cmprint CMWRK01=$CMWRK01 NATLOG=ALL
  rc=$?
  rm /opt/sisve/demonio/lockfile/$PRG.log
else
  echo "no me ejecuto: $fch" >> /opt/sisve/demonio/$PRG.lst
fi
#####
bo=`date +%m/%d/%Y`
do=`date +"%H:%M:%S"`
if test "$a" = ""
then
        echo "$bi $di|$0|$$|$*|$rc|`whoami`|$bo $do" >> /opt/sisve/Shell/estadisticas.log
        sh /opt/sisve/Shell/Estadisticas/stdfin.sh $$ $0 $rc
else
        echo "no registra estadistica" > /dev/null
fi
##############

