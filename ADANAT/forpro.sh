#!/bin/bash

for i in `cat /home/dba02/logs/SRC.log`
do
 find /opt/sisve/nat/fusernjx/SISVE/SRC -name $i -exec ls -l {}  \;
 
done
