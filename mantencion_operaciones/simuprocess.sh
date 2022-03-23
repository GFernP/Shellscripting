#!/bin/bash

sh /home/dba02/myscripts/zipfiles.sh Mar 2017 /fstemp2/DatosSeg02/backupEP |mail -s "Salida backup 1" german.fernandez@softwareag
sh /home/dba02/myscripts/contprocess.sh |mail -s "Salida Shell 1" german.fernandez@softwareag.com
sh /home/dba02/myscripts/revisionpro.sh |mail -s "Salida Shell 2" german.fernandez@softwareag.com
sh /home/dba02/myscripts/conex2.sh |mail -s "Salida Shell 3" german.fernandez@softwareag.com
