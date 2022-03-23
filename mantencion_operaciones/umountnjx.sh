#!/bin/bash

fecha=`date +"%d/%m/%y %H:%M:%S"`
#ssh -t sisve@10.150.156.72 "export TERM=xterm; echo 'sisve' | sudo -S sisve@10.150.156.72 "export TERM=xterm; echo 'sisve' | sudo -S umount 10.150.156.71:/usr/local/EnterprisePlatform511/jboss-eap-5.1/jboss-as/server/node1/deploy/njx82.ear/cisnatural.war/SISVEUI/htmlReport /usr/local/EnterprisePlatform511/jboss-eap-5.1/jboss-as/server/node2/deploy/njx82.ear/cisnatural.war/SISVEUI/htmlReport" 
ssh -t sisve@10.150.156.72 "export TERM=xterm; echo 'sisve' | sudo -S cat /etc/sudoers"
rc=$?

echo "----------------------------------------------------------------------------" >> /home/dba02/logs/statusumountnjx.log
echo $fecha >> /home/dba02/logs/statusumountnjx.log
echo $rc >> /home/dba02/logs/statusumountnjx.log
