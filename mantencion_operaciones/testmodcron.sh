#!/bin/bash

proceso=$1
min=$2
hora=$3
day=$3
mes=$4
sem=$5
dirpro=/home/dba02/myscripts/



if [ $# -eq 2 ]
then
    crontab -l > bckcron
    sed -e /$proceso/d bckcron > newcron
    echo "$min * * * * sh $dirpro$proceso.sh" >> newcron
    crontab newcron
elif [ $# -eq 3 ]
then
    crontab -l > bckcron
    sed -e /$proceso/d bckcron > newcron
    echo "$min $hora * * * sh $dirpro$proceso.sh" >> newcron
    crontab newcron
elif [ $# -eq 4 ]
then
    crontab -l > bckcron
    sed -e /$proceso/d bckcron > newcron
    echo "$min $hora $day * * sh $dirpro$proceso.sh" >> newcron
    crontab newcron
elif [ $# -eq 5 ]
then
    crontab -l > bckcron
    sed -e /$proceso/d bckcron > newcron
    echo "$min $hora $day $mes * sh $dirpro$proceso.sh" >> newcron
    crontab newcron
elif [ $# -eq 6 ]
then
    crontab -l > bckcron
    sed -e /$proceso/d bckcron > newcron
    echo "$min $hora $day $mes $sem sh $dirpro$proceso.sh" >> newcron
    crontab newcron
else
    exit
fi
