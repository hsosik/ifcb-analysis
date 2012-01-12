#!/bin/sh
#find /scratch/ifcb/2009 -name '*.zip' -exec python enqueue_blobfix.py {} \;
for year in /scratch/ifcb/blobs/201*; do
    for day in $year/2*; do
	for zip in $day/*.zip; do
	    if [ -e $zip ]; then
		n=`echo $zip | sed -e 's#.*/##'`
		lid=`echo $n | sed -e 's#_blobs.zip##'`
		nf=`echo $n | sed -e 's#_blobs#_blobs_v2#'`
		t=`echo $day | sed -e 's#blobs#good_blobs#'`
		gb=$t/$nf
		if [ ! -e $t/$nf ]; then
		    echo QUEUE $lid
		    python enqueue_blobfix.py $lid
		fi
	    fi
	done
    done
done

