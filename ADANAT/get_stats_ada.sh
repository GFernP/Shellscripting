#!/usr/bin/bash

LOGDIR=/opt/sisve/Shell/Logs/stats_ada
tiempo=$(date +%Y%m%d_%H%M)
yea=$(date +%Y)
mes=$(date +%m)
dia=$(date +%d)
hora=$(date +%H)

act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi

. ~/.profile > /dev/null

a=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=uq repeat=30" |grep -v grep|awk ' {print $2}'`
b=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=high repeat=30" |grep -v grep|awk ' {print $2}'`
c=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=tt repeat=30" |grep -v grep|awk ' {print $2}'`
d=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=bp repeat=30" |grep -v grep|awk ' {print $2}'`
e=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=commands repeat=30" |grep -v grep|awk ' {print $2}'`
f=`ps -Af |grep "/opt/sag/Adabas/bin/adaopr.bin db=4 display=cq repeat=30" |grep -v grep|awk ' {print $2}'`
kill -INT $a $b $c $d $e $f

sleep 3

cd $LOGDIR

if [ $dia -eq 02 ]
then
    if [ -d $yea ]
    then
        cd $yea
        if [ -d $mes ]
        then
            echo ok >/dev/null
        else
            mkdir -p $mes/adamonactivity
            mkdir -p $mes/adamonindex
            mkdir -p $mes/adamonio
            mkdir -p $mes/adaoprbp
            mkdir -p $mes/adaoprcmd
            mkdir -p $mes/adaoprcq
            mkdir -p $mes/adaoprhig
            mkdir -p $mes/adaoprtt
            mkdir -p $mes/adaopruq
        fi
        cd ..
    else
        mkdir -p $yea/$mes/adamonactivity
        mkdir $yea/$mes/adamonindex
        mkdir $yea/$mes/adamonio
        mkdir $yea/$mes/adaoprbp
        mkdir $yea/$mes/adaoprcmd
        mkdir $yea/$mes/adaoprcq
        mkdir $yea/$mes/adaoprhig
        mkdir $yea/$mes/adaoprtt
        mkdir $yea/$mes/adaopruq
    fi
fi

if [ $dia -eq 01 ]
then
    yea=`TZ=GMT+12 date '+%Y'`
    mes=`TZ=GMT+12 date '+%m'`
fi

if [ $hora -eq 00 ]
then
    ayer=`TZ=GMT+12 date '+%Y%m%d'`
    countf=$(ls *$ayer*.log 2>/dev/null |wc -l)
    if [ $countf -gt 0 ]
    then
        #find . -name adamonactivity_$ayer*.log -exec mv '{}' $yea/$mes/adamonactivity \;
        #find . -name adamonindex_$ayer*.log -exec mv '{}' $yea/$mes/adamonindex \;
        #find . -name adamonio_$ayer*.log -exec mv '{}' $yea/$mes/adamonio \;
        #find . -name adaoprbp_$ayer*.log -exec mv '{}' $yea/$mes/adaoprbp \;
        #find . -name adaoprcmd_$ayer*.log -exec mv '{}' $yea/$mes/adaoprcmd \;
        #find . -name adaoprcq_$ayer*.log -exec mv '{}' $yea/$mes/adaoprcq \;
        #find . -name adaoprhig_$ayer*.log -exec mv '{}' $yea/$mes/adaoprhig \;
        #find . -name adaoprtt_$ayer*.log -exec mv '{}' $yea/$mes/adaoprtt \;
        #find . -name adaopruq_$ayer*.log -exec mv '{}' $yea/$mes/adaopruq \;
        mv adamonactivity_$ayer*.log $yea/$mes/adamonactivity
        mv adamonindex_$ayer*.log $yea/$mes/adamonindex
        mv adamonio_$ayer*.log $yea/$mes/adamonio
        mv adaoprbp_$ayer*.log $yea/$mes/adaoprbp
        mv adaoprcmd_$ayer*.log $yea/$mes/adaoprcmd
        mv adaoprcq_$ayer*.log $yea/$mes/adaoprcq
        mv adaoprhig_$ayer*.log $yea/$mes/adaoprhig
        mv adaoprtt_$ayer*.log $yea/$mes/adaoprtt
        mv adaopruq_$ayer*.log $yea/$mes/adaopruq
    fi
fi

diauno=$(date +%m%d)
if [ $diauno -eq 0101 ]
then
    yeaa=$(TZ=GMT+12 date '+%Y')
    tar -cf $yeaa_statsadabas.tar $yeaa/
    gzip $yeaa_statsadabas.tar
    echo "verificar archivo $LOGDIR/$yeaa_statsadabas.tar.gz y eliminar carpeta de estadisticas Adabas del año anterior"| mailx -s "verificar archivo" german.fernandez@softwareag.com
fi
nohup adaopr db=4 display=uq repeat=30 >> $LOGDIR/adaopruq_$tiempo.log &
nohup adaopr db=4 display=high repeat=30 >> $LOGDIR/adaoprhig_$tiempo.log &
nohup adaopr db=4 display=bp repeat=30 >> $LOGDIR/adaoprbp_$tiempo.log &
nohup adaopr db=4 display=tt repeat=30 >> $LOGDIR/adaoprtt_$tiempo.log &
nohup adaopr db=4 display=commands repeat=30 >> $LOGDIR/adaoprcmd_$tiempo.log &
nohup adaopr db=4 display=cq repeat=30 >> $LOGDIR/adaoprcq_$tiempo.log &

nohup adamon db=4 display=activity loop=20 interval=25 >> $LOGDIR/adamonactivity_$tiempo.log &
nohup adamon db=4 display=index loop=20 interval=25 >> $LOGDIR/adamonindex_$tiempo.log &
nohup adamon db=4 display=io loop=20 interval=25 >> $LOGDIR/adamonio_$tiempo.log &