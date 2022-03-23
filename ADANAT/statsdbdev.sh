#!/bin/bash
act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi
. /home/sag/.profile > /dev/null

dbid=$1
pathlogs=/opt/sisve/Shell/Logs
rm -f $pathlogs/records_file.log
i=1
#for i in {1..230}
sumreg=0
limit=230
while [ $i -le $limit ]
do
    x=`adarep db=$dbid file="$i" |grep "Records loaded:"`
    if echo $x| grep -q "Records"
    then
        fix=`echo $x |awk '{print$3}'|sed 's:[^0-9]::g'`
        echo "$i $fix" >> $pathlogs/records_file.log
        sumreg=`expr $sumreg + $fix`
    fi
i=`expr $i + 1`
done

adaopr db=$dbid display=commands > $pathlogs/db_commands.log
comm1=`cat $pathlogs/db_commands.log |grep ET|awk '{print $2}' |sed 's:[^0-9]::g'`
comm2=`cat $pathlogs/db_commands.log |grep BT|awk '{print $2}' |sed 's:[^0-9]::g'`
comm3=`cat $pathlogs/db_commands.log |grep A1|awk '{print $2}' |sed 's:[^0-9]::g'`
comm4=`cat $pathlogs/db_commands.log |grep E1|awk '{print $2}' |sed 's:[^0-9]::g'`
comm5=`cat $pathlogs/db_commands.log |grep N1 |awk '{print $4}'|sed 's:[^0-9]::g'`
comm6=`cat $pathlogs/db_commands.log |grep "ADABAS Commands" |awk '{print $3}'|sed 's:[^0-9]::g'`

adamon db=$dbid display=io loops=17 > $pathlogs/ios_cont.log
assoio=`cat $pathlogs/ios_cont.log |grep "ASSO I/Os"|awk '{print $5}'`
dataio=`cat $pathlogs/ios_cont.log |grep "DATA I/Os"|awk '{print $5}'`
workio=`cat $pathlogs/ios_cont.log |grep "WORK I/Os"|awk '{print $5}'`
let iototal="($assoio + $dataio + $workio)/ 3"

adamon db=$dbid dis=high loop=1 > $pathlogs/adamonloop1.log
users=`cat $pathlogs/adamonloop1.log |grep Users |awk '{print $2}'|awk -F "|" ' {print $1}'`
assoused=`cat $pathlogs/adamonloop1.log |grep ASSO|awk '{print$2}'|sed 's:[^0-9]::g'`
assototal=`cat $pathlogs/adamonloop1.log |grep ASSO|awk '{print$3}'|sed 's:[^0-9]::g'`
dataused=`cat $pathlogs/adamonloop1.log |grep DATA|awk '{print$2}'|sed 's:[^0-9]::g'`
datatotal=`cat $pathlogs/adamonloop1.log |grep DATA|awk '{print$3}'|sed 's:[^0-9]::g'`
assofree=` expr $assototal - $assoused `
datafree=` expr $datatotal - $dataused `

adaopr db=$dbid display=commands > $pathlogs/db_commands.log
comm11=`cat $pathlogs/db_commands.log |grep ET|awk '{print $2}' |sed 's:[^0-9]::g'`
comm22=`cat $pathlogs/db_commands.log |grep BT|awk '{print $2}' |sed 's:[^0-9]::g'`
comm33=`cat $pathlogs/db_commands.log |grep A1|awk '{print $2}' |sed 's:[^0-9]::g'`
comm44=`cat $pathlogs/db_commands.log |grep E1|awk '{print $2}' |sed 's:[^0-9]::g'`
comm55=`cat $pathlogs/db_commands.log |grep N1 |awk '{print $4}'|sed 's:[^0-9]::g'`
comm66=`cat $pathlogs/db_commands.log |grep "ADABAS Commands" |awk '{print $3}'|sed 's:[^0-9]::g'`

rest1=`expr $comm11 - $comm1`
rest2=`expr $comm22 - $comm2`
rest3=`expr $comm33 - $comm3`
rest4=`expr $comm44 - $comm4`
rest5=`expr $comm55 - $comm5`
summtr=`expr $rest1 + $rest2 + $rest3 + $rest4 + $rest5`

tran=`expr $summtr / 60`
ET=`expr $rest1 / 60`
BT=`expr $rest2 / 60`
A1=`expr $rest3 / 60`
E1=`expr $rest4 / 60`
N1=`expr $rest5 / 60`

#let ET="($comm11 - $comm1)/ 60"
#let BT="($comm22 - $comm2)/ 60"
#let A1="($comm33 - $comm3)/ 60"
#let E1="($comm44 - $comm4)/ 60"
#let N1="($comm55 - $comm5)/ 60"
let CMD="($comm66 - $comm6)/ 60"

rm -f $pathlogs/adamonloop1.log
rm -f $pathlogs/ios_cont.log
rm -f $pathlogs/db_commands.log

echo "Usuarios: $users" > $pathlogs/statsdb$dbid.log
echo "ASSO_Util: $assoused" >> $pathlogs/statsdb$dbid.log
echo "ASSO_Total: $assototal" >> $pathlogs/statsdb$dbid.log
echo "ASSO_Free: $assofree" >> $pathlogs/statsdb$dbid.log
echo "ASSO_IO: $assoio" >> $pathlogs/statsdb$dbid.log
echo "DATA_Util: $dataused" >> $pathlogs/statsdb$dbid.log
echo "DATA_Total: $datatotal" >> $pathlogs/statsdb$dbid.log
echo "DATA_Free: $datafree" >> $pathlogs/statsdb$dbid.log
echo "DATA_IO: $dataio" >> $pathlogs/statsdb$dbid.log
echo "WORK_IO: $workio" >> $pathlogs/statsdb$dbid.log
echo "TOTAL_IO: $iototal" >> $pathlogs/statsdb$dbid.log
echo "Commands x seg: $CMD" >> $pathlogs/statsdb$dbid.log
echo "ET x seg: $ET" >> $pathlogs/statsdb$dbid.log
echo "BT x seg: $BT" >> $pathlogs/statsdb$dbid.log
echo "A1 x seg: $A1" >> $pathlogs/statsdb$dbid.log
echo "E1 x seg: $E1" >> $pathlogs/statsdb$dbid.log
echo "N1 x seg: $N1" >> $pathlogs/statsdb$dbid.log
echo "Tran x seg: $tran" >> $pathlogs/statsdb$dbid.log
echo "Total Registros $dbid: $sumreg" >> $pathlogs/statsdb$dbid.log

sh /opt/sisve/Shell/monitoreo/sumabloksfree.sh $dbid ASSO
sh /opt/sisve/Shell/monitoreo/sumablokstot.sh $dbid ASSO
sh /opt/sisve/Shell/monitoreo/sumabloksfree.sh $dbid DATA
sh /opt/sisve/Shell/monitoreo/sumablokstot.sh $dbid DATA

filed=`date '+%Y%m%d'`
ftrack=/opt/sisve/Shell/Logs/TrackMetrics/metrics$filed.log
fech=`date '+%d/%m/%Y %T'`
echo "$fech, Usuarios, $users" >> $ftrack
echo "$fech, ASSO_Util, $assoused" >> $ftrack
echo "$fech, ASSO_Total, $assototal" >> $ftrack
echo "$fech, ASSO_Free, $assofree" >> $ftrack
echo "$fech, ASSO_IO, $assoio" >> $ftrack
echo "$fech, DATA_Util, $dataused" >> $ftrack
echo "$fech, DATA_Total, $datatotal" >> $ftrack
echo "$fech, DATA_Free, $datafree" >> $ftrack
echo "$fech, DATA_IO, $dataio" >> $ftrack
echo "$fech, WORK_IO, $workio" >> $ftrack
echo "$fech, TOTAL_IO, $iototal" >> $ftrack
echo "$fech, Commands/min, $CMD" >> $ftrack
echo "$fech, ET/min, $ET" >> $ftrack
echo "$fech, BT/min, $BT" >> $ftrack
echo "$fech, A1/min, $A1" >> $ftrack
echo "$fech, E1/min, $E1" >> $ftrack
echo "$fech, N1/min, $N1" >> $ftrack
echo "$fech, Tran/min, $tran" >> $ftrack
echo "$fech, Total Registros $dbid, $sumreg" >> $ftrack