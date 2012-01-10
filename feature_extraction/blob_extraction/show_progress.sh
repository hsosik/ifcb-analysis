#!/bin/sh
nproc=`find /scratch/ifcb/blobs/2* -name "log.txt" | wc -l`
ndays=`find /scratch/ifcb -wholename "/scratch/ifcb/20*/20*_*" -type d | wc | awk '{print $1}'`
echo Processing day ${nproc} of ${ndays} on ${HOSTNAME}
top -b | head -19
