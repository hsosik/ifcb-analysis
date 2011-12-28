#!/bin/sh
nproc=`find /scratch/ifcb/blobs -name "20*_*" | wc | awk '{print $1}'`
ndays=`find /scratch/ifcb -wholename "/scratch/ifcb/20*/20*_*" -type d | wc | awk '{print $1}'`
echo Processing day ${nproc} of ${ndays}
top -b | head -19
