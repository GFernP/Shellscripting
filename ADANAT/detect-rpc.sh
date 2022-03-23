#!/bin/bash

#Proceso de deteccion de sobreconsumo de proceso
#Ejecucion de shell con parametro del proceso a buscar
#ej: sh hprocess.sh natrpc

idpro=$1
count=`ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:40'" {print $0}'|wc -l`

log()
{
  fech=`date +%D_%T`
  FLOG=/opt/sisve/Shell/Logs/consume_$idpro.log
  echo "$fech: Procesos $idpro con alto tiempo de espera de cpu " >> $FLOG
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args|head -1 >> $FLOG
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:40'" {print $0}' >> $FLOG
  print "----------------------------------------------------------" >> $FLOG
}
hkill()
{
  tmpfile=/opt/sisve/Shell/Logs/tmp_$idpro.log
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:40'" {print $2}' > $tmpfile
  cat $tmpfile |
  while read line
  do
    /usr/bin/kill -9 $line
  done
  rm -f $tmpfile
}

sstart()
{
  sisv=`ps -Af |grep "rpc-sisv"|grep -v grep |wc -l`
  natrpc1=`ps -Af |grep NATRPCP1|grep -v grep |wc -l`
  natrpc2=`ps -Af |grep NATRPCP2|grep -v grep |wc -l`
  if [ $sisv -lt 2 ]
  then
    sh /opt/sisve/bin/servrpc.sh start
  fi
  if [ $natrpc1 -lt 3]
  then
    sh /opt/sisve/bin/demonatrcp.sh >> /tmp/log/demonatrpc.log
  fi
  if [ $natrpc2 -lt 3]
  then
    sh /opt/sisve/bin/demonatrcp.sh >> /tmp/log/demonatrpc.log
  fi
}


if [ $count -gt 0 ]
then
  log
  hkill
  sstart
fi

sisv=`ps -Af |grep "rpc-sisv"|grep -v grep |wc -l`
  if [ $sisv -lt 2 ]
  then
    rpfech=`date +%D_%T`
    SISVLOG=/opt/sisve/Shell/Logs/rpc-sisv.log
    echo " $rpfech: deteccion de ausencia de proceso rpc-sisv" >> $SISVLOG
    sh /opt/sisve/bin/servrpc.sh start
    ps -Af |grep -v grep |grep -i rpc-sisv >> $SISVLOG
  fi