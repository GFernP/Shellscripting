#!/usr/bin/bash

echo "/opt/sisve/Shell: " >> $HOME/rsyncstats.log
/usr/bin/rsync -avrz  /opt/sisve/Shell sag@10.150.156.81:/opt/sisve --stats --log-file=$HOME/rsyncstats.log

echo "---------------------------------------" >> $HOME/rsyncstats.log
echo "/opt/sisve/syadba: " >> $HOME/rsyncstats.log
/usr/bin/rsync -avrz  /opt/sisve/syadba sag@10.150.156.81:/opt/sisve --stats --log-file=$HOME/rsyncstats.log

echo "---------------------------------------" >> $HOME/rsyncstats.log
echo "/RespHistorico " >> $HOME/rsyncstats.log
/usr/bin/rsync -avrz /RespHistorico sag@10.150.156.81:/RespHistorico --stats --log-file=$HOME/rsyncstats.log