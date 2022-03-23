#!/usr/bin/bash
#respaldo incremental de objetos NJX
#by GFP
mainpath=/respaldo/bck_sisve_war/Incremental
logpath=/respaldo/bck_sisve_war/Incremental/logs
fechasem=$(date +%Y%m%V)
timestamp=$(date +%D_%T)
dirproj="SISVE30v5 SISVE30v6 SISVE30v6-II SISVE30v7"
dirobj="global SISVEUI STDCSTUI"

namelog() {
    devlog=rsync_objNJX_dev_$fechasem.log
    erdevlog=err_rsync_objNJX_dev_$fechasem.log
    prodlog=rsync_objNJX_prod_$fechasem.log
    erprodlog=err_rsync_objNJX_prod_$fechasem.log
    qalog=rsync_objNJX_qa_$fechasem.log
    erqalog=err_rsync_objNJX_qa_$fechasem.log
    fblog=rsync_objNJX_fb_$fechasem.log
    erfblog=err_rsync_objNJX_fb_$fechasem.log
}

desarrollo() {
dirwf=/usr/local/wildfly/standalone/deployments
echo "Fecha: $timestamp" >> $logpath/$devlog
for i in `echo $dirproj`
do
    echo "########## RECIBIENDO ARCHIVOS DEL PROYECTO $i ##########" >> $logpath/$devlog
    for x in `echo $dirobj`
    do
        rsync -avzh sag@10.136.113.155:$dirwf/$i.war/$x $mainpath/DEV/$i --exclude=htmlReport >> $logpath/$devlog 2>> $logpath/$erdevlog
        rc=$?
        if [ $rc -ne 0 ]
        then
            echo "$timestamp: rsync $i Dev objNJX termina con errores $rc" >> $logpath/$erdevlog
            echo "****************************************************************" >> $logpath/$erdevlog
            exit $rc
        fi
        echo "**********************************************************************" >> $logpath/$devlog
    done
done
}
######################################################################
produccion() {
dirwf=/usr/local/wildfly-9/standalone/deployments
echo "Fecha: $timestamp" >> $logpath/$prodlog
for i in `echo $dirproj`
do
    echo "########## RECIBIENDO ARCHIVOS DEL PROYECTO $i ##########" >> $logpath/$prodlog
    for x in `echo $dirobj`
    do
        rsync -avzh sisve@10.150.156.92:$dirwf/$i.war/$x $mainpath/PRD/$i --exclude=htmlReport >> $logpath/$prodlog 2>> $logpath/$erprodlog
        rc=$?

        if [ $rc -ne 0 ]
        then
            echo "$timestamp: rsync $i PRD objNJX termina con errores $rc" >> $logpath/$erprodlog
            echo "****************************************************************" >> $logpath/$erprodlog
            exit $rc
        fi
        echo "**********************************************************************" >> $logpath/$prodlog
    done
done
}
######################################################################
testing() 
{
dirwf=/opt/wildfly-9/standalone/deployments
echo "Fecha: $timestamp" >> $logpath/$qalog
for i in `echo $dirobj`
do
    echo "########## RECIBIENDO ARCHIVOS DEL PROYECTO $i ##########" >> $logpath/$qalog
    rsync -avzh sisve@10.150.156.36:$dirwf/SISVE30v5.war/$i $mainpath/QA/SISVE30v5 --exclude=htmlReport >> $logpath/$qalog 2>> $logpath/$erqalog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync SISVE30v5 QA objNJX termina con errores $rc" >> $logpath/$erqalog
        echo "****************************************************************" >> $logpath/$erqalog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$qalog
done
}
######################################################################
finalbuild() {
dirwf=/usr/local/wildfly-16.0.0.Final/standalone/deployments
echo "Fecha: $timestamp" >> $logpath/$fblog
for i in `echo $dirobj`
do
    echo "########## RECIBIENDO ARCHIVOS DEL PROYECTO $i ##########" >> $logpath/$fblog
    rsync -avzh $dirwf/SISVE30v7.war/$i $mainpath/FB/SISVE30v7 --exclude=htmlReport >> $logpath/$fblog 2>> $logpath/$erfblog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync SISVE30v7 FB objNJX termina con errores $rc" >> $logpath/$erfblog
        echo "****************************************************************" >> $logpath/$erfblog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$fblog
done
}

##############################################################################################

namelog
dtimei=$(date +%D_%T)
desarrollo
dtimef=$(date +%D_%T)
ptimei=$(date +%D_%T)
produccion
ptimef=$(date +%D_%T)
qtimei=$(date +%D_%T)
testing
qtimef=$(date +%D_%T)
ftimei=$(date +%D_%T)
finalbuild
ftimef=$(date +%D_%T)
echo "tiempo ejecucion rsync desarrollo; $dtimei; $dtimef" >> $logpath/tiempos_rsync_objNJX.log
echo "tiempo ejecucion rsync produccion; $ptimei; $ptimef" >> $logpath/tiempos_rsync_objNJX.log
echo "tiempo ejecucion rsync testing; $qtimei; $qtimef" >> $logpath/tiempos_rsync_objNJX.log
echo "tiempo ejecucion rsync finalbuild; $ftimei; $ftimef" >> $logpath/tiempos_rsync_objNJX.log