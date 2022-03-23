#!/bin/bash

proceso=$1
min=$2
hora=$3
day=$3
mes=$4
sem=$5
dirpro=/home/dba02/myscripts
#dirpro=/opt/sisve/demonio
dirlog=/opt/sisve/Shell/Logs
Fecha=`date +%Y%m%d_%H%M%S`

re='[a-zA-Z]*'
ch=$1
if [[ "$ch" != $re ]]
then
        exit
fi


if [ $# -eq 2 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "$min * * * * sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
elif [ $# -eq 3 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "$min $hora * * * sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
elif [ $# -eq 4 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "$min $hora $day * * sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
elif [ $# -eq 5 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "$min $hora $day $mes * sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
elif [ $# -eq 6 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "$min $hora $day $mes $sem sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
elif [ $# -eq 1 ]
then
    crontab -l > $dirlog/bckcron_$Fecha
    sed -e /$proceso/d $dirlog/bckcron_$Fecha > $dirpro/newcron
    echo "* * * * * sh $dirpro/$proceso.sh" >> $dirpro/newcron
    crontab $dirpro/newcron
else
    exit
fi
