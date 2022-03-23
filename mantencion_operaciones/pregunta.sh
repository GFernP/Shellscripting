#!/bin/bash

y=1
while [ $y -eq 1 ]

do

	echo "Desea eliminar los archivos listados que ya fueron respaldados? [s/n]"
	read q
	clear
	if [ $q == s ]
	then
	#sh $HOME/myscripts/borrfiles.sh $MES $YEAR $DIR
		echo "Archivos Eliminados"
	exit
	fi
	
	if [ $q == n ] 
	then
		echo "exit"
	exit
	else
		echo "Verifique las opciones de repuesta \n"
		echo " s = si, n = no"
		y=1
	fi
done
