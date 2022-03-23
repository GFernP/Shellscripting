#!/usr/bin/bash
#by GFP
# Para corte de PLOG y posterior, transferencia y carga en destino.
####
act=$(cat /opt/sisve/Shell/check.lst)
if test "$act" -eq 0
then
exit
fi
######
. /home/sag3/.profile > /dev/null
#
FCH=$(date +%Y%m%d%H%M%S)
#
cd /BaseSisve/db010
lastPLOG=`ls -t NUCPLG.* | head -1`
numPLOG=`echo $lastPLOG | awk -F "." '{print $2}'`
EXE=`fuser $lastPLOG`
echo '---------------' >> plog.log
echo "$FCH,$lastPLOG,$numPLOG,$EXE" >> plog.log

        echo "--------------------------------------" >> logcorteplog.log
        echo "PLOG CORTADO: $numPLOG" >> logcorteplog
        adaopr db=10 et_sync feof=plog >> logcorteplog.log
        ok=$?
        if [ $ok -ne 0 ]
        then
          echo  "ERROR CIERREPLOG $numPLOG: $ok ver archivo logcorteplog.log" |mail -s "ERROR CIERRE PLOG" german.fernandez@softwareag.com
          echo  "ERROR CIERREPLOG $numPLOG: $ok" >> cutPLOG.log
          exit
        fi
basedir=/respaldo/REPLMT
errlog=$basedir/errorlog.log
lplog=$basedir/diffplog.log
statrec=$basedir/lastatrec.log
serielog=$basedir/serieplog.log
plogt=$lastPLOG

scp -C $plogt sag@10.150.156.81:$basedir/aprocesar

    adarec() {
        
        ssh sag@10.150.156.81 'cd /respaldo/REPLMT; sh adarecdb010.sh "'$1'"'
    }

    /opt/softwareag/Adabas/adarep db=10 check=* |grep SYNC |tail -1 |awk '{print $4}' > sesionplog.log
    lplogo=$(cat sesionplog.log)
    lplogd=$(ssh sag@10.150.156.81 'cd /respaldo/REPLMT; sh checkpointsdb010.sh; cat lastidplog.log')
    rest=$( expr $lplogo - $lplogd )
    if [ $rest -eq 1 ]
    then
        adarec $plogt
    else
        while [ $rest -gt 1 ]
        do
            basedir=/respaldo/REPLMT
            lplogd=$(ssh sag@10.150.156.81 'cd /respaldo/REPLMT; sh checkpointsdb010.sh; cat lastidplog.log')
            plogt=$(ls NUCPLG.* |grep $lplogd)
            scp -C $plogt sag@10.150.156.81:$basedir/aprocesar
            adarec $plogt
            newserie=$( expr $lplogd + 1 )
            lplogo=$(cat sesionplog.log)
            rest=$( expr $lplogo - $newserie )
        done  
    fi