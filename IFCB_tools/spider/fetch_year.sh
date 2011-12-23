#!/bin/bash
YEAR=2010
DATA_NAMESPACE='http://ifcb-data.whoi.edu/mvco/'
DEST=scratch
for i in $(seq 1 366); do
    day=${YEAR}-`printf '%03d' $i`
    feed="${DATA_NAMESPACE}rss.py?day=$day"
    for url in `curl -s $feed | xsltproc atom2csv.xsl - | cut -d, -f 1 | sed -e 's/$/.zip/'`; do
	fn=`echo $url | sed -e 's#.*/##'`
	curl -O $url
	mv $fn $DEST
	echo `date +%Y-%m-%dT%H:%M:%S%Z` $url
    done
done
