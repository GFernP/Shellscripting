#!/bin/bash

df -g |head -1
df -g |grep -e fsasso -e fsdata -e PLOG -e tmp -e respaldo -e opt/sisve |sort -k 4rn
