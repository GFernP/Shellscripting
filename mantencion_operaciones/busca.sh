#!/bin/bash
set -x
i=1
PTFILE=/fstemp2/home/dba2/pattern2.lst
PTCOUNT=2362
DEFILE=/fstemp2/home/dba2/guias20150506.log
while [ $i -le $PTCOUNT ]
do 
x=`cat $PTFILE| sed -n "$i"'p' `
#cat envio2.log |grep $x |grep -ie entrega -e recep >>resultado.log
y=`cat $DEFILE |grep $x |wc -l`
if [ $y -eq 0 ]
then
echo $x >> nofound.log
else
echo -e "$x\t" "$y" >>find.log
fi

i=`expr $i + 1`
done
