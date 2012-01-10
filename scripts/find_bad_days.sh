#!/bin/sh
for day in /scratch/ifcb/blobs/2*/2*; do
    n=`ls $day | grep -v .zip | wc -l`
    if [ ! $n -eq 1 ]; then
	echo FAIL $day
    fi
done