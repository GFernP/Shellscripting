#!/bin/bash

same=0
fechafind=`date +%Y%m%d`
while true
do
	endf=`find /fstemp2/Giros/ -name "Giros_UPU_$fechafind*" -exec ls -t {} \+|head -1`
	
	if  [ "$endf" != "$same" ]
	then
	echo $endf
	grep -i error $endf
	fi
same="$endf"
sleep 3
done
