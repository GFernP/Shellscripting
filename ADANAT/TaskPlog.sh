#!/bin/bash

lockf=`ls $basedir/lockfile.log`
if test "$lockf" = ""
then
touch $basedir/lockfile.log
. /home/sag/.profile > /dev/null
fecha=`date +%D_%T`
basedir=/respaldo/REPLMT
errlog=$basedir/errorlog.log
lplog=$basedir/diffplog.log
statrec=$basedir/lastatrec.log
serielog=$basedir/serieplog.log

ssh -o ConnectTimeout=3 sag@10.150.156.12 'ls -t /BaseSisve/PLOG/db010/PLOG.* |head -1' > /dev/null
RC=$?
if [ $RC -gt 0 ]
then
    echo "ERROR 1010 [$fecha]: Error de conexion ssh $RC" >> $errlog
    echo "ERROR 1010 [$fecha]: Error de conexion ssh $RC" |mail -s "ERROR DRP" german.fernandez@softwareag.com
    rm -f $basedir/lockfile.log
    exit
fi

get() {
    cd $basedir
    scp sag@10.150.156.12:"'$cont'" aprocesar/
    RC=$?
    if [ $RC -gt 0 ]
    then
        echo "ERROR 1020 [$fecha]: Error de copia PLOG de origen a destino $RC" >> $errlog
        echo "ERROR 1020 [$fecha]: Error de copia PLOG de origen a destino $RC" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        rm -f $basedir/lockfile.log
        exit
    fi
}

rec() {
    cd aprocesar
    name=`ls -t PLOG.*|head -1`
    ifproc=`ls -l ../procesados/ |grep -c $name`
    if [ $ifproc -gt 0 ]
    then
        echo "ERROR 1030 [$fecha]: PLOG ya se encuentra procesado" >> $errlog
        echo "ERROR 1030 [$fecha]: PLOG ya se encuentra procesado" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        rm -f $basedir/lockfile.log
        exit
    fi
    export RECPLG=$basedir/aprocesar/$name
    #numplog=`echo $name |awk -F "(" '{print $2}'|awk -F ")" '{print $1}'`
    numplog=`echo $name |awk -F "." '{print $2}'`
    echo "--------------------------------------------------------" >> $statrec
    #adarec db=8 regenerate=*, plog=$numplog,NOBI_CHECK >> $statrec
    adarec db=20 regenerate=*,plog=$numplog >> $statrec
    RC=$?
    # xargs command.txt < lala.log
    # echo "close" |adarec db=8 regenerate=*, plog=$numplog >> $statrec
    if [ $RC -gt 0 ]
    then
        echo "ERROR 1040 [$fecha]: Error de carga de PLOG $RC" >> $errlog
        echo "ERROR 1040 [$fecha]: Error de carga de PLOG $RC, revisar log $statrec" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        exit
    fi   
    echo $numplog >> $serielog
    rm -f $basedir/lockfile.log
    mv $name ../procesados/
}

val() {
    ulplogid=`ls -t $basedir/procesados/PLOG.* |head -1 |awk -F "." '{print $2}'`
    lastid=`cat $lplog |awk -F "." '{print $2}'`
    if [ $ulplogid -lt $lastid ]
    then
        serie=`cat $serielog |tail -1`
        rest=`expr $lastid - $serie`
        while [ $rest -gt 1 ]
        do
            rlast=`expr $lastid - 1`
            if [ $rlast -ge 1000 ]
            then
                echo "/BaseSisve/PLOG/db010/PLOG.$rlast" > $lplog
            else
                echo "/BaseSisve/PLOG/db010/PLOG.0$rlast" > $lplog
            fi
        lastid=`cat $lplog |awk -F "." '{print $2}'`
        rest=`expr $lastid - $serie`
        done
        cont=`cat $lplog`
    elif [ $ulplogid -eq $lastid ]
    then
        sum=`expr $lastid + 1`
        lawk=`echo $last |awk -F "." '{print $2}'`
        if [ $sum -eq $lawk ]
        then
            rm -f $basedir/lockfile.log
            exit
        fi            
        if [ $sum -ge 1000 ]
        then
            echo "/BaseSisve/PLOG/db010/PLOG.$sum" > $lplog
        else
            echo "/BaseSisve/PLOG/db010/PLOG.0$sum" > $lplog
        fi
    cont=`cat $lplog`
    else
        echo "ERROR 1050 [$fecha]: Revisar orden de PLOG regenerados" >> $errlog
        echo "ERROR 1050 [$fecha]: Revisar orden de PLOG regenerados" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        exit
    fi 
}

cont=`cat $lplog`
last=`ssh sag@10.150.156.10 'ls /BaseSisve/PLOG/db010/PLOG.* |tail -1'`
if [ $last = $cont ]
then
    echo $last > $lplog
    rm -f $basedir/lockfile.log
else
    val
    get
    rec
fi

fi