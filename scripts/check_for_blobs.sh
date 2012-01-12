#!/bin/sh
# find blobs for bins given the path of a raw ROI file
roi_path=$1
lid=`echo $roi_path | sed -e 's#.*/##' -e 's/.roi//'`
yearday=`echo $lid | sed -e 's/IFCB._//' -e s'/_......$//'`
year=`echo $yearday | sed -e 's/_...$//'`
if [ ! $year -eq 2012 ]; then
    blob_path=/data/vol4/blobs/$year/$yearday/${lid}_blobs_v2.zip
    if [ ! -e $blob_path ]; then
	bc=`wc -c $roi_path | awk '{print $1}'`
	if [ ! $bc -eq 2 ]; then # ignore 2-byte ROI files
	    echo MISSING $lid
	fi
    fi
fi