#!/bin/bash
set -x
PATH=$1
PATHZ=/respaldo_test/filesbackup
ZIP=$2
TARGET=10.150.156.80
DIRT=/respaldo/tmpfiles
PATHSED="\/respaldo_test\/filesbackup"

#cd $PATH
#/usr/bin/zip $PATHZ/$ZIP *
#/usr/bin/zip $PATHZ/$ZIP -R $PATH*

/usr/bin/find $PATH -type f -mtime +16  -print > $HOME/logs/compress.log
/usr/bin/sed "s/^/\/usr\/bin\/zip -u $PATHSED\/$ZIP /g" $HOME/logs/compress.log > $HOME/logs/compress.sh
/usr/bin/chmod +x $HOME/logs/compress.sh
/usr/bin/sh $HOME/logs/compress.sh

echo "Archivos comprimidos y ubicados en $PATHZ"

/usr/bin/scp $PATHZ/$ZIP $TARGET:$DIRT
echo "Archivo comprimido enviado"
