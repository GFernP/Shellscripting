#!/bin/bash


  cat libcorreosgz.log |
  while read line
  do
    e=`echo $line|sed -e 's/.gz//g'`
    y=`ls $e |wc -l`
    if [ $y -eq 0 ]
        then
        echo "archivo $e no existe"
    else
        rm -f $line
    fi
  done
  

  #!/bin/bash

  cat $tmpfile |
  while read line
  do
    if [ -d $line ]
        then
        echo " $line existe" > $HOME/direxiste.log
        else
        echo "sudo mkdir $line"
        fi
  done