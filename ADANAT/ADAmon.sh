#!/bin/bash
#su - sag
adamon dbid=4 loops=2 disp=hi inter=2 > adamonresp1.tmp
tail -20 adamonresp1.tmp |head -9 >adamon1.dat
tail -8 adamonresp1.tmp |head -7|sed 's/ KB/K/g' >adamon2.dat
#Primer grupo de datos
cut -d':' -f1 adamon1.dat |sed 's/ *$//'|sed 's/ /_/g' >columna0.tmp
cut -d':' -f2 adamon1.dat |sed 's/^ *//'|cut -d' ' -f1 >columna1.tmp
cut -d':' -f2 adamon1.dat |sed 's/^ *//'|cut -d' ' -s -f2- |sed 's/^ *//' >columna2.tmp
paste -d, columna0.tmp columna1.tmp columna2.tmp >datos1.tmp
#Segundo grupo de datos
cut -d':' -f1 adamon2.dat |sed 's/^ //'|sed 's/ *$//'|sed 's/ /_/g' >columna0.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f1 >columna1.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//'|cut -d' ' -f1 >columna2.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//' >columna3.tmp
paste -d, columna0.tmp columna1.tmp columna2.tmp columna3.tmp >datos2.tmp


