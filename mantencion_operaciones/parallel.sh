#!/usr/bin/bash

fechi=`date +%T`

sh ~/myscripts/revisionpro.sh > ~/revisionpro.log &
sh ~/myscripts/contprocess.sh > ~/conteoprocesos.log &
sh ~/myscripts/conex_new.sh > ~/conexionesie11.log &

x=1
a=`ps -Af |grep -v grep|grep -cw "revisionpro"`
b=`ps -Af |grep -v grep|grep -cw "contprocess"`
c=`ps -Af |grep -v grep|grep -cw "conex_new`

while [ $x -eq 1 ]
do
	if [ $a -lt 1 ] && [ $b -lt 1 ] && [ $c -lt 1 ] 
	then
		x=0
	fi
a=`ps -Af |grep -v grep|grep -cw "revisionpro"`
b=`ps -Af |grep -v grep|grep -cw "contprocess"`
c=`ps -Af |grep -v grep|grep -cw "conex_new"`
done

fecht=`date +%T`
echo "Tiempo inicio: $fechi - Tiempo fin: $fecht" > ~/logparallel.log
