#!/bin/sh
while read pid; do
    day=`echo $pid | sed -e 's/IFCB._//' -e 's/_[0-9]*$//'`
    year=`echo $day | sed -e 's/IFCB._//' -e 's/_[0-9]*$//'`
    bad_file=${pid}_blobs.zip
    bad_path=/scratch/ifcb/blobs/$year/$day/$bad_file
    good_file=${pid}_blobs_v2.zip
    good_path=/scratch/ifcb/good_blobs/$year/$day/$good_file
    if [ -e $bad_path -a -e $good_path ]; then
	echo GOOD $pid
    else
	echo BAD $pid
    fi
done



