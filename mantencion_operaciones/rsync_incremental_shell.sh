#!/usr/bin/bash
#respaldo incremental de shellscripts de mantencion, operacion y monitoreo.
#by GFP
mainpath=/respaldo/bck_shellscripts_unimon/Incremental
logpath=/respaldo/bck_shellscripts_unimon/Incremental/logs
fechasem=$(date +%Y%m%V)
timestamp=$(date +%D_%T)
dirshell="Estadisticas limpieza monitoreo operaciones pruebas"
sisveshell=/opt/sisve/Shell
sagshell=/opt/sag/Shell

namelog() {
    devlog=rsync_shellscripts_dev_$fechasem.log
    erdevlog=err_rsync_shellscripts_dev_$fechasem.log
    prodlog=rsync_shellscripts_prod_$fechasem.log
    erprodlog=err_rsync_shellscripts_prod_$fechasem.log
    qalog=rsync_shellscripts_qa_$fechasem.log
    erqalog=err_rsync_shellscripts_qa_$fechasem.log
    fblog=rsync_shellscripts_fb_$fechasem.log
    erfblog=err_rsync_shellscripts_fb_$fechasem.log
}

desarrollo() {
echo "Fecha: $timestamp" >> $logpath/$devlog
for i in `echo $dirshell`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i de Sisve ##########" >> $logpath/$devlog
    rsync -avzh sag@10.136.113.155:$sisveshell/$i $mainpath/DEV/Sisve/ >> $logpath/$devlog 2>> $logpath/$erdevlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i Dev shellscripts Sisve termina con errores $rc" >> $logpath/$erdevlog
        echo "****************************************************************" >> $logpath/$erdevlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$devlog
done

echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO de SAG ##########" >> $logpath/$devlog
    rsync -avzh sag@10.136.113.155:$sagshell/* $mainpath/DEV/SAG/ >> $logpath/$devlog 2>> $logpath/$erdevlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync Dev shellscripts SAG termina con errores $rc" >> $logpath/$erdevlog
        echo "****************************************************************" >> $logpath/$erdevlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$devlog
}
######################################################################
produccion() {
echo "Fecha: $timestamp" >> $logpath/$prodlog
for i in `echo $dirshell`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i de Sisve ##########" >> $logpath/$prodlog
    rsync -avzh sag@10.150.156.10:$sisveshell/$i $mainpath/PRD/Sisve/ >> $logpath/$prodlog 2>> $logpath/$erprodlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i PRD shellscripts Sisve termina con errores $rc" >> $logpath/$erprodlog
        echo "****************************************************************" >> $logpath/$erprodlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$prodlog
done

echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO de SAG ##########" >> $logpath/$prodlog
    rsync -avzh sag@10.150.156.10:$sagshell/* $mainpath/PRD/SAG/ >> $logpath/$prodlog 2>> $logpath/$erprodlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync PRD shellscripts SAG termina con errores $rc" >> $logpath/$erprodlog
        echo "****************************************************************" >> $logpath/$erprodlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$prodlog
}
######################################################################
testing() 
{
echo "Fecha: $timestamp" >> $logpath/$qalog
for i in `echo $dirshell`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i de Sisve ##########" >> $logpath/$qalog
    rsync -avzh sag3@10.150.156.12:$sisveshell/$i $mainpath/QA/Sisve/ >> $logpath/$qalog 2>> $logpath/$erqalog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i QA shellscripts Sisve termina con errores $rc" >> $logpath/$erqalog
        echo "****************************************************************" >> $logpath/$erqalog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$qalog
done

echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO de SAG ##########" >> $logpath/$qalog
    rsync -avzh sag3@10.150.156.12:$sagshell/* $mainpath/QA/SAG/ >> $logpath/$qalog 2>> $logpath/$erqalog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync QA shellscripts SAG termina con errores $rc" >> $logpath/$erqalog
        echo "****************************************************************" >> $logpath/$erqalog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$qalog
}
######################################################################
finalbuild() {
    echo "Fecha: $timestamp" >> $logpath/$fblog
for i in `echo $dirshell`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i de Sisve ##########" >> $logpath/$fblog
    rsync -avzh $sisveshell/$i $mainpath/FB/Sisve/ >> $logpath/$fblog 2>> $logpath/$erfblog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i FB shellscripts Sisve termina con errores $rc" >> $logpath/$erfblog
        echo "****************************************************************" >> $logpath/$erfblog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$fblog
done

echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO de SAG ##########" >> $logpath/$fblog
    rsync -avzh $sagshell/* $mainpath/FB/SAG/ >> $logpath/$fblog 2>> $logpath/$erfblog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync FB shellscripts SAG termina con errores $rc" >> $logpath/$erfblog
        echo "****************************************************************" >> $logpath/$erfblog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$fblog
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
echo "tiempo ejecucion rsync desarrollo; $dtimei; $dtimef" >> $logpath/tiempos_rsync_shellscripts.log
echo "tiempo ejecucion rsync produccion; $ptimei; $ptimef" >> $logpath/tiempos_rsync_shellscripts.log
echo "tiempo ejecucion rsync testing; $qtimei; $qtimef" >> $logpath/tiempos_rsync_shellscripts.log
echo "tiempo ejecucion rsync finalbuild; $ftimei; $ftimef" >> $logpath/tiempos_rsync_shellscripts.log