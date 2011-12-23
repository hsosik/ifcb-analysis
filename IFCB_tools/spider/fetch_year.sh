#!/bin/bash
YEAR=2010
DATA_NAMESPACE='http://ifcb-data.whoi.edu/mvco/'
DEST=/scratch/ifcb/2010
for i in $(seq 1 366); do
    day=${YEAR}-`printf '%03d' $i`
    day_dir=${DEST}/${YEAR}_`printf '%03d' $i`
    mkdir -p ${day_dir}
    feed="${DATA_NAMESPACE}rss.py?day=$day"
    for url in `curl -s $feed | xsltproc atom2csv.xsl - | cut -d, -f 1 | sed -e 's/$/.zip/'`; do
	fn=`echo $url | sed -e 's#.*/##'`
	curl -s -O $url
	mv $fn ${day_dir}
	echo `date +%Y-%m-%dT%H:%M:%S%Z` $url
    done
done
