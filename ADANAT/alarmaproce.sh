#!/bin/bash
#by GFP 05/04/16
#mod 25/04/14, fix de log missing, ahora valida por cantidad de logs.
#mod 30/12/16, fix de log incompleto se agrega ciclo.

d=`date +%d`
file=`ls -t /respaldo/logs/db004* | head -1`
#dfile=`ls -tl /respaldo/logs/db004* |head -1|awk '{print $6}'`
ferror=`cat $file |grep -ic error`
fcount=`ls /respaldo/logs/ |wc -l`
logcount=`cat /opt/sisve/Shell/Logs/logbackupcount.log`
fok=`cat $file |grep -ic "BACKUP 004 OK"`

if test -f $file
then
	#if test $dfile -eq $d
	if test $fcount -gt $logcount
	then
		if [ $ferror -ge 1 ]
		then
		cat $file |mail -s "[PE] Error Backup" mesa.monitoreo@softwareag.com
		#cat $file |mail -s "[PE] Error Backup" german.fernandez@softwareag.com
		ls /respaldo/logs/ |wc -l > /opt/sisve/Shell/Logs/logbackupcount.log
		else
		while [ $fok -eq 0 ]
		do
		echo "wait 3 seconds" > /dev/null
		sleep 3
		fok=`cat $file |grep -ic "BACKUP 004 OK"`
		done
		cat $file |mail -c "efrain.ascanio@softwareag.com" -s "[PE] Backup DB004 OK" mesa.monitoreo@softwareag.com
		#cat $file |mail -s "[PE] Backup DB004 OK" german.fernandez@softwareag.com
		ls /respaldo/logs/ |wc -l > /opt/sisve/Shell/Logs/logbackupcount.log
		fi
	else
	cat /opt/sisve/Shell/Logs/logbackupmissing.txt|mail -s "[PE] Log Missing" mesa.monitoreo@softwareag.com
	#cat /opt/sisve/Shell/Logs/logbackupmissing.txt|mail -s "[PE] Log Missing" german.fernandez@softwareag.com
	ls /respaldo/logs/ |wc -l > /opt/sisve/Shell/Logs/logbackupcount.log
	fi
else
echo "No es un archivo valido" >>/home/dba02/logs/unknowfile.log
ls /respaldo/logs/ |wc -l > /opt/sisve/Shell/Logs/logbackupcount.log
fi
