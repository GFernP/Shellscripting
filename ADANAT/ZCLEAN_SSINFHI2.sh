#!/bin/bash
##########
act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi
####Estadisticas Unimon SISVE
bi=`date +%m/%d/%Y`
di=`date +"%H:%M:%S"`
##########
NSHELL=ZCLEAN_SSINFHI2
PRG=ZCLEAN
fch=`date +%Y%m%d_%H%M%S`

. /home/sisve/.profile > /dev/null
a=`ls /opt/sisve/demonio/lockfile/$PRG.log`
if test "$a" = ""
then
  touch /opt/sisve/demonio/lockfile/$PRG.log
  nfile=$1
  flag=0
  cp /DatosSeg02/Marca-Historial/Aprocesar/$nfile /respaldo/tmpfiles/Log_Historiales/$nfile_$fch
  cmsynin=/opt/salida/$PRG-cmd-$fch.txt            # Comando
  cmobjin=/opt/salida/$PRG-input-$fch.txt          # data para el PRGrama / input
  cmprint=/opt/salida/$PRG-output-$fch.txt         # salida
  cmprt01=/opt/salida/$PRG-report1-$fch.txt
  export WRKF1=/opt/salida/$PRG_WF1.txt  # as defined in natparm
  export WRKF3=/opt/salida/$PRG_WF3.txt  # as defined in natparm
  export WRKF4=/opt/salida/$PRG_WF4.txt
  CMWRK01=/opt/salida/$PRG-wrk01-$fch.txt
  salida=/opt/salida/$PRG-out-$fch.txt
  lib=SISVE
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
  echo  "$nfile \n" > $cmobjin
echo 'BATCHAPP $BATCHAPP'
  natural batchmode bp=$BPAPP parm=$BATCHAPP etid=$$ cc=on cmsynin=$cmsynin cmobjin=$cmobjin CMPRT01=$cmprt01 cmprint=$cmprint CMWRK01=$CMWRK01 NATLOG=ALL
  rc=$?
  rm /opt/sisve/demonio/lockfile/$PRG.log
else
  echo "no me ejecuto: $fch" >> /opt/sisve/demonio/$PRG.lst
fi
#####
if [ $rc -eq 0 ]
then
    rm -f /DatosSeg02/Marca-Historial/Aprocesar/$nfile
    cp /tmp/log/isnFoundHist.txt /DatosSeg02/Marca-Historial/Aprocesar/$nfile
    sh /opt/sisve/demonio/m_SSINFHI2.sh $nfile
    ###Las siguientes lineas son para resolver la falla de zclean al limpiar algunos archivos.Add 18/07/03 by GFP###
    again=$(grep -c "The specified ISN was invalid" `ls -t /opt/salida/SSINFHI2-output-* |head -1`)
    if [ $again -gt 0 ]
    then
        sh /opt/sisve/demonio/ZCLEAN_SSINFHI2.sh $nfile
        flag=1
    fi
    if [ $flag -eq 0 ]
    then
        log1=`cat $cmprint`
        log2=$(cat `ls -t /opt/salida/SSINFHI2-output-* |head -1`)
        echo "$log1 \n**************************************************************\n $log2" |mail -s "FIX error SSINFHI2 $nfile" mesa.monitoreo@softwareag.com
    fi
    ######################################################################
else
    echo "verificar la falla de la shell de limpieza $NSHELL, error $rc" |mail -s "[PE] Error de Proceso Batch" mesa.monitoreo@softwareag.com
fi
bo=`date +%m/%d/%Y`
do=`date +"%H:%M:%S"`
echo "$bi $di|$0|$$|$*|$rc|`whoami`|$bo $do" >> /opt/sisve/Shell/estadisticas.log
