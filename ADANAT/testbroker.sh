#!/bin/bash

etb1=`etbcmd -b ETB022 -c PING -d BROKER`
ok=lol

if echo "$etb1" | grep -q "$ok"
then
echo "$ok"
else
echo "Caida Broker en maquina 10.150.156.25" |mail -s "Broker Down" german.fernandez@softwareag.com
fi


etb2=`etbcmd -b ETB024 -c PING -d BROKER`

if echo "$etb2" | grep -q "$ok"
then
echo "$ok"
else
echo "Caida Broker en maquina 10.150.156.26" |mail -s "Broker Down" german.fernandez@softwareag.com
fi

