#!/usr/bin/bash
#respaldo incremental de objetos Natural
#by GFP
mainpath=/respaldo/bck_objetos_natural/Incremental
logpath=/respaldo/bck_objetos_natural/Incremental/logs
fechasem=$(date +%Y%m%V)
timestamp=$(date +%D_%T)
dirfuser="fuser30 fuser302 fuser303 fuser304 fuser305"

namelog() {
    devlog=rsync_objNatural_dev_$fechasem.log
    erdevlog=err_rsync_objNatural_dev_$fechasem.log
    prodlog=rsync_objNatural_prod_$fechasem.log
    erprodlog=err_rsync_objNatural_prod_$fechasem.log
    qalog=rsync_objNatural_qa_$fechasem.log
    erqalog=err_rsync_objNatural_qa_$fechasem.log
    fblog=rsync_objNatural_fb_$fechasem.log
    erfblog=err_rsync_objNatural_fb_$fechasem.log
}

desarrollo() {
echo "Fecha: $timestamp" >> $logpath/$devlog
for i in `echo $dirfuser`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i ##########" >> $logpath/$devlog
    rsync -avzh sag@10.136.113.155:/opt/sag2/objetos/$i $mainpath/DEV/ >> $logpath/$devlog 2>> $logpath/$erdevlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i Dev objNatural termina con errores $rc" >> $logpath/$erdevlog
        echo "****************************************************************" >> $logpath/$erdevlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$devlog
done
}
######################################################################
produccion() {
echo "Fecha: $timestamp" >> $logpath/$prodlog
for i in `echo $dirfuser`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i ##########" >> $logpath/$prodlog
    rsync -avzh sag@10.150.156.10:/opt/sisve/sisve3/$i $mainpath/PRD/ >> $logpath/$prodlog 2>> $logpath/$erprodlog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i PRD objNatural termina con errores $rc" >> $logpath/$erprodlog
        echo "****************************************************************" >> $logpath/$erprodlog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$prodlog
done
}
######################################################################
testing() 
{
echo "Fecha: $timestamp" >> $logpath/$qalog
for i in `echo $dirfuser`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i ##########" >> $logpath/$qalog
    rsync -avzh sag3@10.150.156.12:/opt/sagSisve3/$i $mainpath/QA/ >> $logpath/$qalog 2>> $logpath/$erqalog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i QA objNatural termina con errores $rc" >> $logpath/$erqalog
        echo "****************************************************************" >> $logpath/$erqalog
        exit $rc
    fi
    echo "**********************************************************************" >> $logpath/$qalog
done
}
######################################################################
finalbuild() {
    echo "Fecha: $timestamp" >> $logpath/$fblog
for i in `echo $dirfuser`
do
    echo "########## RECIBIENDO ARCHIVOS DEL DIRECTORIO $i ##########" >> $logpath/$fblog
    rsync -avzh /opt/softwareag/Natural/$i $mainpath/FB/ >> $logpath/$fblog 2>> $logpath/$erfblog
    rc=$?
    if [ $rc -ne 0 ]
    then
        echo "$timestamp: rsync $i FB objNatural termina con errores $rc" >> $logpath/$erfblog
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
echo "tiempo ejecucion rsync desarrollo; $dtimei; $dtimef" >> $logpath/tiempos_rsync_objNatural.log
echo "tiempo ejecucion rsync produccion; $ptimei; $ptimef" >> $logpath/tiempos_rsync_objNatural.log
echo "tiempo ejecucion rsync testing; $qtimei; $qtimef" >> $logpath/tiempos_rsync_objNatural.log
echo "tiempo ejecucion rsync finalbuild; $ftimei; $ftimef" >> $logpath/tiempos_rsync_objNatural.log