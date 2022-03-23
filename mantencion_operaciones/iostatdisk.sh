#!/bin/bash

FSTART=`date +%d/%m/%Y_%H:%M:%S`
echo $FSTART > $1
iostat -f |grep "Disks:" >> $1
iostat 1 3600 |grep hdisk12 >> $1
FEND=`date +%d/%m/%Y_%H:%M:%S`
echo $FEND >> $1
