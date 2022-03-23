#!/bin/bash

cat $HOME/naturalerr.log |
while read line
do
   cont=`grep -c "Parameter File     : BATCH" $line`

    if [ $cont -ge 1 ]
    then
        echo "No encontrado siga" >/dev/null
    else
        echo "$line" 
    fi
done

