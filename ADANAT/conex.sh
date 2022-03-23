#!/bin/bash

fich=/home/dba02/logs/net.$$
fich1=/home/dba02/logs/net1.$$
fich2=/home/dba02/logs/net2.$$
ipmia="10.150.156....23000"
ipmia1="10.150.156....40000"
ipmia2="10.150.156....40001"
netstat -na |grep $ipmia | grep -v grep >$fich
netstat -na |grep $ipmia1 | grep -v grep >$fich1
netstat -na |grep $ipmia2 | grep -v grep >$fich2
echo " SERVIDOR        \tNSW  NWO-40000  NWO-40001" 
echo "-----------------------------------------------"
sproce=0
sproce1=0
sproce2=0
for i in 51 53 55 56 71 72 73 74
do
ip="10.150.156.$i"
ipport="10.150.156.$i.$port"
if [ "$i" == 51 ] || [ "$i" == 53 ] || [ "$i" == 55 ] || [ "$i" == 56 ]
then
	proce=`grep $ip $fich | grep -i esta |grep -v grep |wc -l`
	proce1=0
	proce2=0
	echo "$ip  \t$proce \t$proce1 \t$proce2"
fi
if [ "$i" == 71 ] || [ "$i" == 72 ]
then
	proce1=`grep $ip $fich1 | grep -i esta |grep -v grep |wc -l`
	proce=0
	proce2=0
	echo "$ip:40000 \t$proce$proce1\t$proce2"
fi
if [ "$i" == 73 ] || [ "$i" == 74 ]
then
        proce2=`grep $ip $fich2 | grep -i esta |grep -v grep |wc -l`
	proce1=0
	proce=0
	echo "$ip:40001\t$proce \t$proce1$proce2"
fi
sproce=`expr $sproce + $proce`
sproce1=`expr $sproce1 + $proce1`
sproce2=`expr $sproce2 + $proce2`
done
echo "\t \t \t$sproce \t$sproce1 \t$sproce2"
natnsw=`ps -ef |grep natnsw |grep -v grep |wc -l `
natnsw1=`expr $natnsw - 1`
natnwo=`ps -ef |grep natnwo |grep -v grep |wc -l `
numada=`adaopr db=4 disp=hi |grep -i "User Queue" | awk '{print $4}' `

echo "natnsw = $natnsw"
echo "natnwo = $natnwo"
echo "adabas = $numada"
f1=`expr $natnsw + $natnwo`
f2=`expr $numada - $f1`
echo "nsw + nwo             = "$f1"" 
echo "Adabas -(NWO & NSW)   = "$f2
