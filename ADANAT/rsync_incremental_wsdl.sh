#!/usr/bin/bash
#respaldo incremental de objetos WSDL
#by GFP
mainpath=/respaldo/bck_wsdl_sisve/Incremental
logpath=/respaldo/bck_wsdl_sisve/Incremental/logs
fechasem=$(date +%Y%m%V)
timestamp=$(date +%D_%T)

namelog() {
    prodlog=rsync_objWSDL_prod_$fechasem.log
    erprodlog=err_rsync_objWSDL_prod_$fechasem.log
    qalog=rsync_objWSDL_qa_$fechasem.log
    erqalog=err_rsync_objWSDL_qa_$fechasem.log
}

testing() {
dirwf=/opt/sag/profiles/CTP/workspace/wsstack/repository/services
echo "Fecha: $timestamp" >> $logpath/$qalog
        rsync -avzh sag@10.150.156.30:$dirwf/*.aar $mainpath/QA >> $logpath/$qalog 2>> $logpath/$erqalog
        rc=$?
        if [ $rc -ne 0 ]
        then
            echo "$timestamp: rsync QA objWSDL termina con errores $rc" >> $logpath/$erqalog
            echo "****************************************************************" >> $logpath/$erqalog
            exit $rc
        fi
        echo "**********************************************************************" >> $logpath/$qalog
}
######################################################################
produccion() {
dirwf1=/opt/sag/profiles/CTP/workspace/wsstack/repository/services
echo "Fecha: $timestamp" >> $logpath/$prodlog
        rsync -avzh sag@10.150.156.25:$dirwf1/*.aar $mainpath/PRD/nodo1 >> $logpath/$prodlog 2>> $logpath/$erprodlog
        rc=$?
        if [ $rc -ne 0 ]
        then
            echo "$timestamp: rsync PRD objWSDL nodo1 termina con errores $rc" >> $logpath/$erprodlog
            echo "****************************************************************" >> $logpath/$erprodlog
            exit $rc
        fi
        echo "**********************************************************************" >> $logpath/$prodlog

dirwf2=/opt/sag/profiles/CTP/workspace/wsstack/repository/services
        rsync -avzh sag@10.150.156.26:$dirwf2/*.aar $mainpath/PRD/nodo2 >> $logpath/$prodlog 2>> $logpath/$erprodlog
        rc=$?
        if [ $rc -ne 0 ]
        then
            echo "$timestamp: rsync PRD objWSDL nodo2 termina con errores $rc" >> $logpath/$erprodlog
            echo "****************************************************************" >> $logpath/$erprodlog
            exit $rc
        fi
        echo "**********************************************************************" >> $logpath/$prodlog
}

##############################################################################################

namelog
qtimei=$(date +%D_%T)
testing
qtimef=$(date +%D_%T)
ptimei=$(date +%D_%T)
produccion
ptimef=$(date +%D_%T)
echo "tiempo ejecucion rsync testing; $qtimei; $qtimef" >> $logpath/tiempos_rsync_objWSDL.log
echo "tiempo ejecucion rsync produccion; $ptimei; $ptimef" >> $logpath/tiempos_rsync_objWSDL.log
