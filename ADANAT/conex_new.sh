#!/bin/bash

tiempoi=`date +%T`
fich1=/home/dba02/logs/net1.$$
fich2=/home/dba02/logs/net2.$$
ipmia1="10.150.156....40000"
ipmia2="10.150.156....40001"
netstat -na |grep $ipmia1 | grep -v grep >$fich1
netstat -na |grep $ipmia2 | grep -v grep >$fich2
echo -e " SERVIDOR        \tNWO-00  NWO-01  (00)+(01)"
echo "--------------------------------------------------------"

sproce1=0
sproce2=0
sprocet=0
for i in 91 92 93 94
do
	ip="10.150.156.$i"
	#ipport="10.150.156.$i.$port"
	proce1=`grep $ip $fich1 | grep -i esta |grep -v grep |wc -l`
	proce2=`grep $ip $fich2 | grep -i esta |grep -v grep |wc -l`
	proceto=`expr $proce1 + $proce2`
	echo -e "$ip: \t  $proce1   $proce2      $proceto"
	sproce1=`expr $sproce1 + $proce1`
	sproce2=`expr $sproce2 + $proce2`
	sprocet=`expr $sprocet + $proceto`
done
echo -e "Total(40000 + 40001)\t$sproce1 \t   $sproce2     $sprocet"
echo -e "\n"

natnwo=`ps -ef |grep natnwo |grep -v grep |wc -l `
numada=`adaopr db=4 disp=hi |grep -i "User Queue" | awk '{print $4}'|sed 's:[^0-9]::g' `

echo "Natnwo =     $natnwo"
echo -e "Adabas = \t  $numada"

f2=`expr $numada - $natnwo`

echo "Adabas - Natnwo = "$f2""

rm -f /home/dba02/logs/net1.$$ 
rm -f /home/dba02/logs/net2.$$

tiempof=`date +%T`
echo "Inicio: $tiempoi - Fin: $tiempof"
