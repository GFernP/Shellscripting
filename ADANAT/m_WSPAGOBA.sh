#!/usr/bin/bash
#Shell de prueba para lanzar proceso de Shell que lee archivos de directorio
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
sftpbatch=/opt/sisve/bin/batchpagoweb.sftp

 . /home/tsisve/.profile > /dev/null
a=`ls /opt/sisve/demonio/lockfile/m_wspagoba.log`
if test "$a" = ""
then
  touch /opt/sisve/demonio/lockfile/m_wspagoba.log
  cd /PagosWeb/paso
  sshpass -f /opt/sisve/bin/passftp.txt sftp -C -oBatchMode=no -b $sftpbatch ext_liferay@201.238.220.53
  RC=$?
  if [ $RC -gt 0 ]
  then
    echo "$bi $di Error conexion SFTP" >> /opt/sisve/demonio/m_wspagoba.lst
    rm /opt/sisve/demonio/lockfile/m_wspagoba.log
    exit
  fi
  for i in ./pagos_*.txt
  do
    c=$(ls ../Procesados |grep -c $i)
    if [ $c -gt 0 ]
    then
        rm $i
    else
    mv $i ../Aprocesar
    fi
  done
  archivo=" "
  for i in /PagosWeb/Aprocesar/*
  do
    if [ -f $i ]
    then
      a=`fuser "$i"|awk '{print($1)}'`
      if test "$a" = ""
      then
        archivo=`expr substr $i 33 60`
        sh /opt/sisve/demonio/WSPAGOBA.sh $archivo
        rc=$?
      fi
    fi
  done
  rm /opt/sisve/demonio/lockfile/m_wspagoba.log
else
        echo "no puedo ejecutarme $bi $di" >> /opt/sisve/demonio/m_wspagoba.lst
fi
##############
bo=`date +%m/%d/%Y`
do=`date +"%H:%M:%S"`
if test "$a" = ""
then
        echo "$bi $di|$0|$$|$*|$rc|`whoami`|$bo $do" >> /opt/sisve/Shell/estadisticas.log
fi
##############

