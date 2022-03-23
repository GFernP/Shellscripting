#!/usr/bin/bash

find /interfaces2 -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' > listdir.txt
#find /ResPlog -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /tmp/ocxFile -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /tmp/html -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /tmp/log -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /opt/sag -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /work -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /RespHistorico -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /respaldo -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /erp -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /GeneraRespaldoHistorial -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /PLOG -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /opt/sisve -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /fsasso -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisvealiex -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosConsultaMasiva2 -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /ftp -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosConsultaOT -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /GeneraGuiaCasillas -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisvesap -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisvecva -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisvealer -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisveLog -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /interfaces -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /GeneraInformacionCartero -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosSeguimiento -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosIPS -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosCVA -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /Cronos -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /sisveMensajeria -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /SAAP -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /TransferenciaSucursal -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosConsultaMasiva -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /historial -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /fstemp2 -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
#find /fsdata -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
find /DatosSeg02 -type d -exec ls -ld {} \+|awk '{print $1,$3,$4,$5,$9}' >> listdir.txt
