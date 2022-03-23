#!/bin/bash

month=JanFebMarAprMayJunJulAugSepOctNovDec

echo "Verificacion de parametro"
echo $*
i=`echo $* | awk ' {print $2} '`
echo $i
mes=Apr
echo $#
