#!/bin/bash
#created by GFP 20/07/15

fecha=`date +%d%m%y`

fstart=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $1}'`
echo "Fecha y hora de inicio:\t $fstart" > $HOME/SVSACA_$fecha.log

name=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $2}'`
echo "Objeto/Shell:\t\t $name" >> $HOME/SVSACA_$fecha.log

pid=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $3}'`
echo "PID:\t\t\t $pid" >> $HOME/SVSACA_$fecha.log

ok=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $5}'`
echo "Código de retorno:\t  $ok" >> $HOME/SVSACA_$fecha.log

user=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $6}'`
echo "Usuario de ejecución:\t  $user" >> $HOME/SVSACA_$fecha.log

fend=`grep SVCSACA1 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $7}'`
echo "Fecha y hora Fin:\t $fend" >> $HOME/SVSACA_$fecha.log

echo "\n" >> $HOME/SVSACA_$fecha.log

fstart1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $1}'`
echo "Fecha y hora de inicio:\t $fstart1" >> $HOME/SVSACA_$fecha.log

name1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $2}'`
echo "Objeto/Shell:\t\t $name1" >> $HOME/SVSACA_$fecha.log

pid1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $3}'`
echo "PID:\t\t\t $pid1" >> $HOME/SVSACA_$fecha.log

ok1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $5}'`
echo "Código de retorno:\t  $ok1" >> $HOME/SVSACA_$fecha.log

user1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $6}'`
echo "Usuario de ejecución:\t  $user1" >> $HOME/SVSACA_$fecha.log

fend1=`grep SVCSACA2 /opt/sisve/Shell/estadisticas.log|tail -1 |awk -F "|" '{print $7}'`
echo "Fecha y hora Fin:\t $fend1" >> $HOME/SVSACA_$fecha.log

cat $HOME/SVSACA_$fecha.log |mail -s "Ejecucion Proceso historiales Sacas" german.fernandez@softwareag.com
