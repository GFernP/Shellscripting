#!/bin/sh
#
#Script for Start/Stop nodes ETBNUC
#by GFP 08/08/18

nombre=`basename $0`
case "$1" in
  start)
    echo "Iniciando ETB022-NATRPCSERVER1, ETB024-NATRPCSERVER2"
    ssh sag@10.150.156.25 "export TERM=xterm; etbstart ETB022 > /dev/null"
    ssh sag@10.150.156.26 "export TERM=xterm; etbstart ETB024 > /dev/null"
    sleep 5
    ssh sag@10.150.156.25 "export TERM=xterm; cat /usr/local/softwareag/EntireX/config/etb/ETB022/ETB.LOG|grep ETBM0750"
    ssh sag@10.150.156.26 "export TERM=xterm; cat /usr/local/softwareag/EntireX/config/etb/ETB024/ETB.LOG|grep ETBM0750"
    echo "done..."
    ;;
  stop)
    echo "Bajando ETB022-NATRPCSERVER1, ETB024-NATRPCSERVER2"
    ssh sag@10.150.156.25 "export TERM=xterm; etbcmd -b ETB022 -c SHUTDOWN -d BROKER"
    ssh sag@10.150.156.26 "export TERM=xterm; etbcmd -b ETB024 -c SHUTDOWN -d BROKER"
    ssh sag@10.150.156.25 "export TERM=xterm; cd /usr/local/softwareag/EntireX/config/etb/ETB022; y=`date +%s`; mv ETB.LOG ETB.LOG.$y"
    ssh sag@10.150.156.26 "export TERM=xterm; cd /usr/local/softwareag/EntireX/config/etb/ETB024; y=`date +%s`; mv ETB.LOG ETB.LOG.$y"
    echo "done..."
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac
