#!/usr/bin/bash
#respaldo incremental de demonios o scripts Sisve
#by GFP
mainpath=/respaldo/bck_demonios_sisve/Incremental
logpath=/respaldo/bck_demonios_sisve/Incremental/logs
fechasem=$(date +%Y%m%V)
timestamp=$(date +%D_%T)

dtimei=$(date +%D_%T)
rsync -avzh sag@10.136.113.155:/opt/sisve/demonio $mainpath/DEV/ >> $logpath/rsync_demonio_dev_$fechasem.log 2>> $logpath/err_rsync_demonio_dev_$fechasem.log
rc=$?
if [ $rc -ne 0 ]
then
    echo "$timestamp: rsync Dev demonio termina con errores $rc" >> $logpath/err_rsync_demonio_dev_$fechasem.log
    echo "****************************************************************" >> $logpath/err_rsync_demonio_dev_$fechasem.log
    exit $rc
fi
echo "**********************************************************************" >> $logpath/rsync_demonio_dev_$fechasem.log
dtimef=$(date +%D_%T)
######################################################################
ptimei=$(date +%D_%T)
rsync -avzh sag@10.150.156.10:/opt/sisve/demonio $mainpath/PRD/ >> $logpath/rsync_demonio_prod_$fechasem.log 2>> $logpath/err_rsync_demonio_prod_$fechasem.log
rc=$?
if [ $rc -ne 0 ]
then
    echo "$timestamp: rsync PRD demonio termina con errores $rc" >> $logpath/err_rsync_demonio_prod_$fechasem.log
    echo "****************************************************************" >> $logpath/err_rsync_demonio_prod_$fechasem.log
    exit $rc
fi
echo "**********************************************************************" >> $logpath/rsync_demonio_prod_$fechasem.log
ptimef=$(date +%D_%T)
######################################################################
qtimei=$(date +%D_%T)
rsync -avzh sag@10.150.156.12:/opt/sisve/demonio $mainpath/QA/ >> $logpath/rsync_demonio_qa_$fechasem.log 2>> $logpath/err_rsync_demonio_qa_$fechasem.log
rc=$?
if [ $rc -ne 0 ]
then
    echo "$timestamp: rsync QA demonio termina con errores $rc" >> $logpath/err_rsync_demonio_qa_$fechasem.log
    echo "****************************************************************" >> $logpath/err_rsync_demonio_qa_$fechasem.log
    exit $rc
fi
echo "**********************************************************************" >> $logpath/rsync_demonio_qa_$fechasem.log
qtimef=$(date +%D_%T)
######################################################################
ftimei=$(date +%D_%T)
rsync -avzh /opt/sisve/demonio $mainpath/FB/ >> $logpath/rsync_demonio_fb_$fechasem.log 2>> $logpath/err_rsync_demonio_fb_$fechasem.log
rc=$?
if [ $rc -ne 0 ]
then
    echo "$timestamp: rsync FB demonio termina con errores $rc" >> $logpath/err_rsync_demonio_fb_$fechasem.log
    echo "****************************************************************" >> $logpath/err_rsync_demonio_fb_$fechasem.log
    exit $rc
fi
echo "**********************************************************************" >> $logpath/rsync_demonio_fb_$fechasem.log
ftimef=$(date +%D_%T)


echo "tiempo ejecucion rsync desarrollo; $dtimei; $dtimef" >> $logpath/tiempos_rsync_demonios.log
echo "tiempo ejecucion rsync produccion; $ptimei; $ptimef" >> $logpath/tiempos_rsync_demonios.log
echo "tiempo ejecucion rsync testing; $qtimei; $qtimef" >> $logpath/tiempos_rsync_demonios.log
echo "tiempo ejecucion rsync finalbuild; $ftimei; $ftimef" >> $logpath/tiempos_rsync_demonios.log