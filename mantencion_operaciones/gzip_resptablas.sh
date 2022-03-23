#!/usr/bin/bash

file=$1

for i in `ls $file/`
do
	gzip $file/$i
done
