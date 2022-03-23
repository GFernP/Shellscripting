#!/usr/bin/bash
#Rsync objetos Natural de PRD-QA-FB to DEV
#luego copia de DEV a server cloud

fecha=`date +%D`
fch=`date +%Y%m%d`

dirQA=/respFuentes/QA
dirPRD=/respFuentes/PROD
dirFB=/respFuentes/FB
dirlog=/respFuentes/logs
timei=`date +%T`
toDEV()
{
    oriQA=/opt/sagSisve3/fuser305
    oriPRD=/opt/sisve/sisve3/fuser304
    oriFB=/opt/softwareag/Natural/fuser305
    rsync -aqcr sag@10.150.156.10:$oriPRD $dirPRD >> $dirlog/errorPRDtoDEV.log
    rcoPRD=$?
    rsync -aqcr sag3@10.150.156.12:$oriQA $dirQA >> $dirlog/errorQAtoDEV.log
    rcoQA=$?
    rsync -aqcr sag@10.136.112.26:$oriFB $dirFB >> $dirlog/errorFBtoDEV.log
    rcoFB=$?
    echo "----------------------------------------" >> $dirlog/errorPRDtoDEV.log
    echo "----------------------------------------" >> $dirlog/errorQAtoDEV.log
    echo "----------------------------------------" >> $dirlog/errorFBtoDEV.log
}

toCLOUD()
{
    desQA=/respaldo/QA/NAT
    desFB=/respaldo/TEST/NAT
    desPRD=/respaldo/PROD/NAT
    rsync -aqcr $dirPRD/fuser304 sag@190.196.218.6:$desPRD >> $dirlog/errorDEVPRtoCLOUD.log
    rcdPRD=$?
    rsync -aqcr $dirQA/fuser305 sag@190.196.218.6:$desQA >> $dirlog/errorDEVQAtoCLOUD.log
    rcdQA=$?
    rsync -aqcr $dirFB/fuser305 sag@190.196.218.6:$desFB >> $dirlog/errorDEVFBtoCLOUD.log
    rcdFB=$?
    echo "----------------------------------------" >> $dirlog/errorDEVPRtoCLOUD.log
    echo "----------------------------------------" >> $dirlog/errorDEVQAtoCLOUD.log
    echo "----------------------------------------" >> $dirlog/errorDEVFBtoCLOUD.log
}

toDEV
toCLOUD

timef=`date +%T`

echo "QAtoDEV;$timei;$timef;$rcoQA" >> $dirlog/rsyncfuentes.log
echo "PRDtoDEV;$timei;$timef;$rcoPRD" >> $dirlog/rsyncfuentes.log
echo "FBtoDEV;$timei;$timef;$rcoFB" >> $dirlog/rsyncfuentes.log
echo "DEVQAtoCLOUD;$timei;$timef;$rcdQA" >> $dirlog/rsyncfuentes.log
echo "DEVPRtoCLOUD;$timei;$timef;$rcdPRD" >> $dirlog/rsyncfuentes.log
echo "DEVFBtoCLOUD;$timei;$timef;$rcdFB" >> $dirlog/rsyncfuentes.log

suma=`expr $rcdPRD + $rcdQA + $rcdFB + $rcoPRD + $rcoQA + $rcoFB`
echo "$suma" > $dirlog/alerta.log

