#/bin/bash


namepro=$1
pro=`ps -Af |grep $namepro |grep -v grep |grep -v alarmpro |wc -l`

while [ $pro -gt 0 ]
do
 sleep 3
 pro=`ps -Af |grep $namepro |grep -v grep |grep -v alarmpro |wc -l`
done
echo "Verifique replicacion!!" |mail -s "Initial state Finalizado" germanfernandez.p@gmail.com
