#!/bin/sh
outdir=training_blobs
csv=training_blobs.csv
curl -s http://ifcb-data.whoi.edu/mvco/training_set.sh > $outdir/$csv
while read line; do
    class=`echo $line | sed -e 's/,.*//'`
    pid=`echo $line | sed -e 's#.*/##'`
    sub=$outdir/$class
    sh get_blob.sh $pid $sub
done < "$outdir/$csv"

