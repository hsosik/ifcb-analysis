#!/bin/bash
YEAR=$1
DATA_NAMESPACE='http://ifcb-data.whoi.edu/mvco/'
DEST=/scratch/ifcb/${YEAR}
START=$2
STEP=$3
for i in $(seq $START $STEP 365); do # 366 for leap years!
    day=${YEAR}-`printf '%03d' $i`
    day_dir=${DEST}/${YEAR}_`printf '%03d' $i`
    mkdir -p ${day_dir}
    feed="${DATA_NAMESPACE}rss.py?day=$day"
    for url in `curl -s $feed | xsltproc atom2csv.xsl - | cut -d, -f 1 | sed -e 's/$/.zip/'`; do
	fn=`echo $url | sed -e 's#.*/##'`
	if [ -e ${day_dir}/${fn} ]; then
	    echo `date +%Y-%m-%dT%H:%M:%S%Z` $START of $STEP SKIPPING $url
	else
	    curl -s -O $url
	    mv $fn ${day_dir}
	    echo `date +%Y-%m-%dT%H:%M:%S%Z` $START of $STEP FETCHED $url
	fi
    done
done
