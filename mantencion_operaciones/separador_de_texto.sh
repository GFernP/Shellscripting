#!/usr/bin/bash


file=$1

cat $file |
while read i
do
    mes=$(echo $i |awk '{print $1}')
    case $mes in
    January)
        dia=$(echo $i|awk '{print $2}' |awk -F "," '{print $1}')
        year=$(echo $i|awk '{print $3}' |awk -F "," '{print $1}')
        hora=$(echo $i |awk '{print $4}')
        huso=$(echo $i |awk '{print $5}')
        dia2=$(echo $i|awk '{print $7}' |awk -F "," '{print $1}')
        year2=$(echo $i|awk '{print $8}' |awk -F "," '{print $1}')
        hora2=$(echo $i |awk '{print $9}')
        huso2=$(echo $i |awk '{print $10}')
        echo "$dia-01-$year $hora $huso,$dia2-01-$year2 $hora2 $huso2" >> ~/new_$file.csv
        ;;
    February)
        dia=$(echo $i|awk '{print $2}' |awk -F "," '{print $1}')
        year=$(echo $i|awk '{print $3}' |awk -F "," '{print $1}')
        hora=$(echo $i |awk '{print $4}')
        huso=$(echo $i |awk '{print $5}')
        dia2=$(echo $i|awk '{print $7}' |awk -F "," '{print $1}')
        year2=$(echo $i|awk '{print $8}' |awk -F "," '{print $1}')
        hora2=$(echo $i |awk '{print $9}')
        huso2=$(echo $i |awk '{print $10}')
        echo "$dia-02-$year $hora $huso,$dia2-02-$year2 $hora2 $huso2" >> ~/new_$file.csv
        ;;
    March)
        dia=$(echo $i|awk '{print $2}' |awk -F "," '{print $1}')
        year=$(echo $i|awk '{print $3}' |awk -F "," '{print $1}')
        hora=$(echo $i |awk '{print $4}')
        huso=$(echo $i |awk '{print $5}')
        dia2=$(echo $i|awk '{print $7}' |awk -F "," '{print $1}')
        year2=$(echo $i|awk '{print $8}' |awk -F "," '{print $1}')
        hora2=$(echo $i |awk '{print $9}')
        huso2=$(echo $i |awk '{print $10}')
        echo "$dia-03-$year $hora $huso,$dia2-03-$year2 $hora2 $huso2" >> ~/new_$file.csv
        ;;
    April)
        dia=$(echo $i|awk '{print $2}' |awk -F "," '{print $1}')
        year=$(echo $i|awk '{print $3}' |awk -F "," '{print $1}')
        hora=$(echo $i |awk '{print $4}')
        huso=$(echo $i |awk '{print $5}')
        dia2=$(echo $i|awk '{print $7}' |awk -F "," '{print $1}')
        year2=$(echo $i|awk '{print $8}' |awk -F "," '{print $1}')
        hora2=$(echo $i |awk '{print $9}')
        huso2=$(echo $i |awk '{print $10}')
        echo "$dia-04-$year $hora $huso,$dia2-04-$year2 $hora2 $huso2" >> ~/new_$file.csv
        ;;
    esac
done

    