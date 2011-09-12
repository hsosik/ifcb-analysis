#!/bin/sh

FEED="http://ifcb-data.whoi.edu/rss.py?format=atom&date=now"
for line in `curl -s $FEED | xsltproc atom2csv.xsl - | head -5`; do
    pid="$(echo $line | cut -d, -f1)"
    lid="$(echo $pid | sed -e 's/.*IFCB/IFCB/')"
    medium=${pid}/mosaic/medium.jpg
    small=${pid}/mosaic/small.jpg
    curl -s $medium > /dev/null
    curl -s $small > /dev/null
done