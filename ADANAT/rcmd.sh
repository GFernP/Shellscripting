#!/bin/bash

. /home/sag/.profile > /dev/null

log=/home/dba02/logs/command_db04.log

adamon db=4 rcmd loops=10 >> $log
echo "**************************************************************************************************************************************" >> $log
