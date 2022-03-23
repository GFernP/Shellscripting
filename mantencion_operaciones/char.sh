#!/bin/bash

re='[a-zA-Z]*'
ch=$1
if [[ "$ch" != $re ]]
then
	echo OK
fi
