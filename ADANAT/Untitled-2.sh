#!/usr/bin/bash
#Levanta natrpc30 de QA
#Por problemas de payload las instancias de este natrpc son 4

act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi

. /home/sag3/.profile >/dev/null

idpro=$1
count=`ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:00'" {print $0}'|wc -l`

log()
{
  fech=`date +%D_%T`
  FLOG=/opt/sisve/Shell/Logs/consume_$idpro.log
  echo "$fech: Procesos $idpro con alto tiempo de espera de cpu " >> $FLOG
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args|head -1 >> $FLOG
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:00'" {print $0}' >> $FLOG
  echo "----------------------------------------------------------" >> $FLOG
}

hkill()
{
  tmpfile=/opt/sisve/Shell/Logs/tmp_$idpro.log
  ps -Af -o ruser,pid,cpu,time,rssize,vsz,args |grep $idpro |grep -v grep|awk '$4>="'01:00'" {print $2}' > $tmpfile
  cat $tmpfile |
  while read line
  do
    /usr/bin/kill -9 $line
  done
  rm -f $tmpfile
}

sstart()
{
  natrpc3=`ps -Af |grep $idpro |grep -v grep |wc -l`
  
    if [ $natrpc3 -eq 0 ]
    then
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 2 ]
    then
        nohup natrpc parm=natrpc30 &    
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 3 ]
    then
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 4 ]
    then
        nohup natrpc parm=natrpc30 &
    fi
}

if [ $count -gt 0 ]
then
  log
  hkill
  sstart
fi

natrpc3=`ps -Af |grep $idpro |grep -v grep |wc -l`

if [ $natrpc3 -lt 4 ]
then
    rpfech=`date +%D_%T`
    SISVLOG=/opt/sisve/Shell/Logs/track-natrpc.log
    echo "------------------------------------------------------------------------------" >> $SISVLOG
    echo " $rpfech: deteccion de ausencia de proceso $idpro" >> $SISVLOG
fi
    if [ $natrpc3 -eq 0 ]
    then
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 2 ]
    then
        nohup natrpc parm=natrpc30 &    
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 3 ]
    then
        nohup natrpc parm=natrpc30 &
        nohup natrpc parm=natrpc30 &
    elif [ $natrpc3 -lt 4 ]
    then
        nohup natrpc parm=natrpc30 &
    fi