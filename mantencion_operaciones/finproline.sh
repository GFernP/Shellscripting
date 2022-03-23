#!/bin/bash

#set -x

###### Buscador de procesos online en las Estadisticas ########

###Fecha a buscar formato dd/mm/yyyy ####

fecha=$1

AYER=`TZ=GMT+23 date '+%m-%d-%Y'`

nombre=` echo $fecha |awk -F "/" '{print $3$2$1}' `

lfech=`cat /tmp/log/EstadistONLINE.log |grep -n $fecha | awk ' {print $1 } ' |awk -F ":" '{print $1}' |head -1`

lfile=`cat /tmp/log/EstadistONLINE.log |wc -l`

ope=` expr $lfech - 1 `

rest=` expr $lfile - $ope `

tail -$rest /tmp/log/EstadistONLINE.log |grep -i svsadfm3 > $HOME/svsadfm3_$nombre.log

tail -$rest /tmp/log/EstadistONLINE.log |grep -i SVBEAFXC > $HOME/svbeafxc_$nombre.log

cat /opt/sisve/Shell/estadisticas.$AYER.log |grep -i Historial.ksh > $HOME/historial_$nombre.log
cat /opt/sisve/Shell/estadisticas.$AYER.log |grep -i datoscomp.ksh > $HOME/datoscomp_$nombre.log
cat /opt/sisve/Shell/estadisticas.$AYER.log |grep -w m_SSINFHI4  > $HOME/ssinfhi4_$nombre.log
cat /opt/sisve/Shell/estadisticas.$AYER.log |grep -w m_SSINFHI1  > $HOME/ssinfhi1_$nombre.log

