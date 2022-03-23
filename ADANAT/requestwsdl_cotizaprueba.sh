#!/usr/bin/bash

fech=$(date +%Y%m%d)
cotizalog=/tmp/log/cotiza_capas_$fech.log
tiempo=$(date +%D_%T)
pathlog=/opt/sisve/Shell/Logs
cd /opt/sisve/Shell/operaciones
/usr/bin/curl -i -X POST -H "Content-Type: text/xml" --data @cotizacionprueba.xml "http://10.150.156.26:10010/wsstack/services/CotizacionPrueba?wsdl" -w @responsetime_cotizacionteset.txt > $pathlog/reqcotiprueba.tmp

timews=$(cat $pathlog/reqcotiprueba.tmp |grep time_total |awk '{print $2}'|awk -F "," '{print $1}'| awk -F "." '{print $1$2}')

timenat=$( tail -1 /tmp/log/cotiza_capas_$fech.log |awk '{print $11}'|awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }' )

timeada=$( tail -1 /tmp/log/cotiza_capas_$fech.log |awk '{print $17}'|awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }' )

msnat=$(awk -vp=$timenat -vq=1000 'BEGIN{printf "%.0f" ,p * q}')
msada=$(awk -vp=$timeada -vq=1000 'BEGIN{printf "%.0f" ,p * q}')
sumadanat=$(($msnat + $msada))
mssoa=$(expr $timews - $sumadanat)
if [ $mssoa -lt 0 ];then
mssoa=0
fi

echo "$tiempo;tiempo_full;$timews;tiempo_natural;$msnat;tiempo_fichero;$msada;tiempo_soa;$mssoa" >> $pathlog/cotizapruebatiempos_$fech.log
echo "requestws: $timews" > $pathlog/timescapas.tmp
echo "timenatural: $msnat" >> $pathlog/timescapas.tmp
echo "timesdb: $msada" >> $pathlog/timescapas.tmp
echo "timesoa": $mssoa >> $pathlog/timescapas.tmp
