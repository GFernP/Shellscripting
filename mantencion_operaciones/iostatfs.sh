#!/bin/bash

FSTART=`date +%d/%m/%Y_%H:%M:%S`

echo $FSTART > $1
iostat -f |grep "FS Name" >> $1
iostat -f 1 3600 |grep /tmp >> $1
FEND=`date +%d/%m/%Y_%H:%M:%S`
echo $FEND >> $1
