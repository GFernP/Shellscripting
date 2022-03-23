#!/bin/bash
####
act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi
####
##########
####Estadisticas Unimon SISVE
bi=`date +%m/%d/%Y`
di=`date +"%H:%M:%S"`
##########
 . /home/sisve/.bash_profile > /dev/null
date >> /home/sisve/SSCCVP09.log
a=`ls /opt/sisve/demonio/lockfile/cbapv9.log`
if test "$a" = ""
then
  touch /opt/sisve/demonio/lockfile/cbapv9.log
  archivo=" "
  for i in /DatosCVA/GeneraGuiaArmado/Aprocesar/*
  do
    if [ -f $i ]
    then
      a=`fuser "$i"|awk '{print($1)}'`
      if test "$a" = ""
      then
        archivo=`expr substr $i 38 40`
        sh /opt/sisve/demonio/New_SSCCVP09.sh $archivo
        rc=$?
       else
        echo "no hago nada" >> /dev/null
      fi
    fi
  done
  rm /opt/sisve/demonio/lockfile/cbapv9.log
else
        echo "no puedo ejecutarme $bi $di" >> /opt/sisve/demonio/ssccvp09.log
fi
##############
bo=`date +%m/%d/%Y`
do=`date +"%H:%M:%S"`
if test "$a" = ""
then
        echo "$bi $di|$0|$$|$*|$rc|`whoami`|$bo $do" >> /opt/sisve/Shell/estadisticas.log
else
        echo "no registra estadistica" > /dev/null
fi
##############