#!/bin/bash

. /home/sag/.profile > /dev/null

log=/home/dba02/logs/adaoprcomm_db04.log

adaopr db=04 display=commands>> $log
echo "**************************************************************************************************************************************" >> $log
