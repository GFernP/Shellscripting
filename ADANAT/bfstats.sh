#!/bin/bash

. /home/dba02/.profile

fecha=`date +%y%m%d_%H%M%S`

adaopr db=4 display=bf > /home/dba02/logs/displaybf$fecha.log
cat /home/dba02/logs/displaybf$fecha.log | mail -s "Buffer Flush statistics" mesa.monitoreo@softwareag.com
