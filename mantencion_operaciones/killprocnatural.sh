#!/usr/bin/bash

#by GFP 18/03/19
##Elimina conexiones Natural, Natnwo o SSH de más de 24 hrs.

patron=$1
lkill=/opt/sisve/Shell/Logs/killtrack.log
y=0

if [ $patron = natural ]
then
    for i in `ps -Af |grep $patron |grep -v grep|grep "parm=NDVPARM"|awk '{print $2}' `
    do
        count=`ps -Af |grep $i|grep -v grep |awk '{print $5}'|grep -c [a-zA-Z]`
        if [ $count -gt 0 ]
        then 
            regpid=`ps -Af |grep $i|grep -v grep`
            echo $regpid >> $lkill
            sudo /usr/bin/kill -9 $i
            y=1
        fi
    done
elif [ $patron = natnwo ]
then
    for i in `ps -Af |grep $patron |grep -v grep| awk '{print $2}' `
    do
        count=`ps -Af |grep $i|grep -v grep |awk '{print $5}'|grep -c [a-zA-Z]`
        if [ $count -gt 0 ]
        then 
            regpid=`ps -Af |grep $i|grep -v grep`
            echo $regpid >> $lkill
            sudo /usr/bin/kill -9 $i
            y=1
        fi
    done
elif [ $patron = ssh ]
then
    for i in `who -u |awk ' {print $6}'`
    do
        #count=`who -u |grep $i|awk '{print $5}' |grep -c [a-zA-Z]`
        ##Las siguientes lineas buscan las conexiones ssh del día anterior, la linea anterior solo buscaba el uso de cpu
        hoy=`date '+%Y-%m-%d'`
        count=`who -u |grep $i |grep -c $hoy`  
        ###
        if [ $count -eq 0 ]
        then
            regwho=`who -u |grep $i`
            echo $regwho >> $lkill
            sudo /usr/bin/kill -9 $i
            y=1
        fi
    done
else 
    echo "opcion incorrecta elija: natnwo o natural o ssh"
fi
if [ $y -eq 1 ]
then
    Fecha=`date  '+%d/%m/%Y %H:%M:%S'`
    echo "***************" >> $lkill
    echo $Fecha >> $lkill
    echo "=======================================================" >> $lkill
fi