#!/usr/bin/bash
#by GFP 21/02/19

id=`whoami`;if [ $id != "sag" ]; then echo "ejecutar con usuario SAG"; exit ; fi
basedir=/opt/sisve/REPLMT
lockf=`ls $basedir/lockfile.log`
if test "$lockf" = ""
then
touch $basedir/lockfile.log
. /home/sag/.profile > /dev/null
fecha=`date +%D_%T`
dbprd=10
dbcont=10
ip=10.150.156.81
errlog=$basedir/errorlog.log
infolog=$basedir/infolog.log
lplog=$basedir/diffplog.log
statrec=$basedir/lastatrec.log
historec=$basedir/historec.log
serielog=$basedir/serieplog.log

#ssh -o ConnectTimeout=3 sag@$ip "ls -t /PLOG/plog.* |head -1" > /dev/null
ssh -o ConnectTimeout=3 sag@$ip "ls /imagenesPDA/testadabas/NUCPLG.* |head -1" > /dev/null
RC=$?
if [ $RC -gt 0 ]
then
    echo "ERROR 1010 [$fecha]: Error de conexion ssh $RC" >> $errlog
    echo "ERROR 1010 [$fecha]: Error de conexion ssh $RC" |mail -s "ERROR DRP" german.fernandez@softwareag.com
    rm -f $basedir/lockfile.log
    exit
fi

get() {
    numeplog=$1
    #plogp=$(ssh sag@$ip "ls /PLOG/plog.* |grep $numeplog")
    ifproc=`ls /imagenesPDA/testadabas/procesados/ |grep -c $numeplog`
    x=0
    if [ $ifproc -gt 0 ]
    then
        echo "ERROR 1030 [$fecha]: PLOG $numeplog ya se encuentra procesado" >> $errlog
        echo "ERROR 1030 [$fecha]: PLOG $numeplog ya se encuentra procesado" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        x=1
        rm -f $1
    fi
    if [ $x -eq 0 ]
    then
    plogp=$(ssh sag@$ip "ls /imagenesPDA/testadabas/NUCPLG.* |grep $numeplog")
    fuplog=$(ssh sag@$ip "fuser $plogp|awk '{print $1}'")
    if [ "$fuplog" == "" ]
    then
        #scp -C sag@$ip:"$plogp" /PLOG/aprocesar
        scp -C sag@$ip:"$plogp" /imagenesPDA/testadabas/aprocesar
        RC=$?
        if [ $RC -gt 0 ]
        then
            echo "ERROR 1020 [$fecha]: Error de copia PLOG $plogp de origen a destino $RC" >> $errlog
            echo "ERROR 1020 [$fecha]: Error de copia PLOG $plogp de origen a destino $RC" |mail -s "ERROR DRP" german.fernandez@softwareag.com
            rm -f $basedir/lockfile.log
            exit
        fi
        #plogc=$(ls /PLOG/aprocesar/plog.* |grep $numeplog)
        plogc=$(ls /imagenesPDA/testadabas/aprocesar/NUCPLG.* |grep $numeplog)
        rec $plogc
        
    else
        echo "ERROR 1050 [$fecha]: Plog $plogp se encuentra tomado por proceso Adanuc u otro" >> $errlog
        echo "ERROR 1050 [$fecha]: Plog $plogp se encuentra tomado por proceso Adanuc u otro"|mail -s "ERROR DRP" german.fernandez@softwareag.com
        rm -f $basedir/lockfile.log
        exit
    fi
    fi
}

rec() {
    #cd aprocesar
    #name=$(echo $1 |awk -F "/" '{print $4}')
    name=$(echo $1 |awk -F "/" '{print $5}')
    #ifproc=`ls -l /PLOG/procesados/ |grep -c $name`
 
    export RECPLG=$1
    numplog=`echo $name |awk -F "." '{print $2}'`
    echo "--------------------------------------------------------" >> $historec
    #adarec db=8 regenerate=*, plog=$numplog,NOBI_CHECK >> $statrec
    adarec db=$dbcont regenerate=*,plog=$numplog |tee -a $historec > $statrec
    RC=$(cat $statrec|grep -c "ADAREC-I-ABORTED")
    # xargs command.txt < lala.log
    # echo "close" |adarec db=8 regenerate=*, plog=$numplog >> $statrec
    if [ $RC -gt 0 ]
    then
        echo "ERROR 1040 [$fecha]: Error de carga de PLOG $numplog " >> $errlog
        #echo "ERROR 1040 [$fecha]: Error de carga de PLOG $RC, revisar log $statrec" |mail -s "ERROR DRP" german.fernandez@softwareag.com
        body="ERROR 1040 [$fecha]: Error de carga de PLOG $numplog, revisar log $statrec"
        sh /opt/sag/Shell/sendMail.sh german.fernandez@softwareag.com "ERROR DRP" "$body" "$statrec"
        exit
    fi
    check=$(. /home/sag/.profile >/dev/null; adarep db=$dbprd check=* |grep SYNC |grep -c "PLOG=$numplog")
    if [ $check -eq 1 ]
    then
        echo "INFO 1020 [$fecha]: PLOG $numplog cargado correctamente" >> $infolog
    else
        echo "ERROR 1060 [$fecha]: Plog $numplog no se encuentra cargado, verificar salida de carga y checkpoints" >> $errlog
        echo "ERROR 1060 [$fecha]: Plog $numplog no se encuentra cargado, verificar salida de carga y checkpoints" |mail -s "ERROR DRP" german.fernandez@softwareag.com 
    fi
    echo $numplog > $serielog
    rm -f $basedir/lockfile.log
    #mv $1 /PLOG/procesados/
    mv $1 /imagenesPDA/testadabas/procesados/
    
}

    splogcont=$(. /home/sag/.profile >/dev/null; adarep db=$dbprd check=* |grep SYNC |tail -1|awk '{print $4}')
    checkprod=$(ssh sag@$ip ". /home/sag/.profile >/dev/null; adarep db=$dbcont check=* |grep SYNC |tail -1")
    splogprod=$(echo $checkprod|awk '{print $4}')
    rest=$( expr $splogprod - $splogcont )
    if [ $rest -le 1 ]
    then
        echo "INFO 1010 [$fecha]: PLOG sigue ocupado en Produccion PlogProd=$splogprod PlogCont=$splogcont" >> $infolog
        rm -f $basedir/lockfile.log
    else
        while [ $rest -gt 1 ]
        do
            tplog=$( expr $splogcont + 1)
            get $tplog
            rest=$(expr $splogprod - $splogcont)
            splogcont=$(. /home/sag/.profile >/dev/null; adarep db=$dbprd check=* |grep PLOG|grep SYNX|tail -1|awk '{print $6}'|awk -F "=" '{print $3}')
        done  
    fi
fi