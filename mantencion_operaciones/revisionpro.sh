#!/bin/bash

tiempoi=`date +%T`
######  Revision programas #####

naturals=`ps -Af |grep "natural batchmode" |grep -v grep`
demonios=`ps -Af |grep demonio |grep -v grep`
shells=`ps -Af |grep -i shell |grep -v grep`
lockfiles=`ls -l /opt/sisve/demonio/lockfile`
hconsumo=`ps -Af | head -1 ;ps -Af |grep -v grep | grep -ie natnwo -e natnsw|awk ' $4>"'10'" { print $0 } '`
natrpc=`ps -Af |grep -i natrpc |grep -v grep`
dia=`date +%d`
fechafind=`date +%Y%m%d`
giros=`find /fstemp2/Giros/ -name "Giros_UPU_$fechafind*" -exec ls -lt {} \+ |wc -l `
ocx=`ls -l /ocx/ |awk '$7=="'$dia'" {print $0}' |wc -l `

echo "###################################################"
echo "PROCESOS NATURAL"
echo "###################################################"
echo -e "$naturals \n"

echo "###################################################"
echo "DEMONIOS"
echo "###################################################"
echo -e "$demonios \n"

echo "###################################################"
echo "PROCESOS SHELLS"
echo "###################################################"
echo -e "$shells \n"

echo "###################################################"
echo "LOCKFILES"
echo "###################################################"
echo -e "$lockfiles \n"

echo "###################################################"
echo "PROCESOS NATNWO CON ALTO CONSUMO"
echo "###################################################"
echo -e "$hconsumo \n"

echo "###################################################"
echo "PROCESOS NATRPC"
echo "###################################################"
echo -e "$natrpc \n"

echo "###################################################"
echo "CONTADOR DE ARCHIVOS DEL DIA DE GIROS Y OCX"
echo "###################################################"
echo "Numero de archivos de Giros" 
echo -e "$giros \n"
echo "Numero de archivos en OCX"
echo -e "$ocx \n"
tiempof=`date +%T`
echo "Inicio: $tiempoi - Fin: $tiempof"
