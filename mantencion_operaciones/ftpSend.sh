#!/bin/sh
#
# Transferencia de archivo al Linux Testing
# Por Angel Mendoza Osuna
#

#cd /tmp/html 
SERVER=10.150.156.81
USER=$1
PASSW=$2

ftp -v -n $SERVER <<END_OF_SESSION
user $USER $PASSW

quit
END_OF_SESSION
