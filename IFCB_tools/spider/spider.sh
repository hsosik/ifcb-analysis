#!/bin/sh

DATE=now
DEST=/home/joe/data/ifcb

while true; do
    FEED="http://ifcb-data.whoi.edu/rss.py?format=atom&date=${DATE}"
    echo "Fetching feed @ ${FEED}..."
    for line in `curl -s $FEED | xsltproc atom2csv.xsl - | tail -n +2`; do
	pid="$(echo $line | cut -d, -f1)"
	updated="$(echo $line | cut -d, -f2)"
	lid="$(echo $pid | sed -e 's/.*IFCB/IFCB/')"
	dir=${DEST}/"$(echo $lid | sed -e 's/_......$//')"
	for ext in adc roi hdr; do
            fn=${pid}.${ext}
	    echo Fetching ${fn}...
	    mkdir -p ${dir}
	    curl -s ${fn} -o ${dir}/${lid}.${ext}
	done
    done
    DATE=${updated}
done



