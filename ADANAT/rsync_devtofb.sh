#!/bin/bash
###Rsync de objetos SISVE30 y xml CISNATURAL
fch=`date  '+%d.%m.20%y %H:%M:%S'`
echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log
echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log
date >> /respaldo/logs/rsync_desa.log
echo "MCD:" >> /respaldo/logs/rsync_desa.log
rsync -av  -delete-before sag@10.136.113.155:/opt/softwareag/Natural/fuser30/MCD /opt/softwareag/Natural/fuser30/MCD >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

date >> /respaldo/logs/rsync_desa.log
echo "SISVE:" >> /respaldo/logs/rsync_desa.log
rsync -av  -delete-before sag@10.136.113.155:/opt/softwareag/Natural/fuser30/SISVE /opt/softwareag/Natural/fuser30/SISVE >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

date >> /respaldo/logs/rsync_desa.log
echo "STDCST:" >> /respaldo/logs/rsync_desa.log
rsync -av  -delete-before sag@10.136.113.155:/opt/softwareag/Natural/fuser30/STDCST /opt/softwareag/Natural/fuser30/STDCST >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

date >> /respaldo/logs/rsync_desa.log
echo "CORREOS:" >> /respaldo/logs/rsync_desa.log
rsync -av  -delete-before sag@10.136.113.155:/opt/softwareag/Natural/fuser30/CORREOS /opt/softwareag/Natural/fuser30/CORREOS >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

echo "SISVEUI:" >> /respaldo/logs/rsync_desa.log
rsync -av --delete-before sag@10.136.113.155:/usr/local/wildfly-9/standalone/deployments/cisnatural.war/SISVEUI /usr/local/wildfly-10.0.0.Final/standalone/deployments/cisnatural.war/SISVEUI >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

echo "STDCSTUI:" >> /respaldo/logs/rsync_desa.log
rsync -av --delete-before sag@10.136.113.155:/usr/local/wildfly-9/standalone/deployments/cisnatural.war/STDCSTUI /usr/local/wildfly-10.0.0.Final/standalone/deployments/cisnatural.war/STDCSTUI >> /respaldo/logs/rsync_desa.log

echo "################################################################ $fch " >> /respaldo/logs/rsync_desa.log

echo "JANUI:" >> /respaldo/logs/rsync_desa.log
rsync -av --delete-before sag@10.136.113.155:/usr/local/wildfly-9/standalone/deployments/cisnatural.war/JANUI /usr/local/wildfly-10.0.0.Final/standalone/deployments/cisnatural.war/JANUI >> /respaldo/logs/rsync_desa.log

echo "***************************************************************************************************************************************** $fch " >> /respaldo/logs/rsync_desa.log


mv /usr/local/wildfly-10.0.0.Final/standalone/deployments/cisnatural.war.deployed /usr/local/wildfly-10.0.0.Final/standalone/deployments/cisnatural.war.dodeploy
