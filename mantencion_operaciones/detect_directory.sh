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
