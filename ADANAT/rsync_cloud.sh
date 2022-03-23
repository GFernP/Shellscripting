#!/bin/bash
###Rsync de objetos Natural Fuser30 y  NJX de Produccion.
##by GFP 15/05/2018

fch=`date  '+%d.%m.20%y %H:%M:%S'`
logrc=/opt/sag2/logs/rsync_to_cloudbck.log
echo "################################################################ $fch " >> $logrc
echo "################################################################ " >> $logrc
echo " Objetos Natural Sisve 3" >> $logrc
date >> $logrc
echo "NAT_Fuser30:" >> $logrc
rsync -avc /opt/sag2/objetos/fuser30 sag@190.196.218.6:/respaldo/NEWDEV/NAT >> $logrc
echo "NAT_Fuser302:" >> $logrc
rsync -avc /opt/sag2/objetos/fuser302 sag@190.196.218.6:/respaldo/NEWDEV/NAT302 >> $logrc

echo "################################################################  " >> $logrc
echo "Archivos XML Sisve 3" >> $logrc
date >> $logrc
echo "Sisve30v3:" >> $logrc
rsync -avc /usr/local/wildfly/standalone/deployments/SISVE30v3.war sag@190.196.218.6:/respaldo/NEWDEV/NJXv3/ >> $logrc
echo "Sisve30v5:" >> $logrc
rsync -avc /usr/local/wildfly/standalone/deployments/SISVE30v5.war sag@190.196.218.6:/respaldo/NEWDEV/NJXv5/ >> $logrc
echo "cisnatural:" >> $logrc
rsync -avc /usr/local/wildfly/standalone/deployments/cisnatural.war sag@190.196.218.6:/respaldo/NEWDEV/NJX/ >> $logrc

fch=`date  '+%d.%m.20%y %H:%M:%S'`
echo "***************************************************************************************************************************************** $fch " >> $logrc