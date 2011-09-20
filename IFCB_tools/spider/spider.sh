#!/bin/sh

# retrieve all IFCB raw data

# start now
DATE=now
# here's where to put the downloaded data
DEST=/home/joe/data/ifcb

# eventually this'll run out of data to fetch; it does not test for that condition
while true; do
    # from the current date (starting with now, but adjusted each loop),
    # get a feed of recent data in Atom format
    FEED="http://ifcb-data.whoi.edu/rss.py?format=atom&date=${DATE}"
    echo "Fetching feed @ ${FEED}..."
    # Convert the atom feed to CSV using atom2csv.xsl, and skip the first line
    # skipping the line is for iterations >=2 so on the first iteration will miss one bin
    for line in `curl -s $FEED | xsltproc atom2csv.xsl - | tail -n +2`; do
        # get pid, timestamp, local id, and compute destination day directory
        pid="$(echo $line | cut -d, -f1)"
        updated="$(echo $line | cut -d, -f2)"
        lid="$(echo $pid | sed -e 's/.*IFCB/IFCB/')"
        dir=${DEST}/"$(echo $lid | sed -e 's/_......$//')"
        # get all three raw files (.adc, .hdr, .roi)
        for ext in adc roi hdr; do
            # url to fetch from
            url=${pid}.${ext}
            # destination file
            file=${dir}/${lid}.${ext}
            if [ -e ${file} ]; then
                echo Already fetched ${url}.
            else
                echo Fetching ${url}...
                # make sure destination day dir exists
                mkdir -p ${dir}
                # fetch to temporary file
                curl -s ${url} -o ${file}.part
                # move into place
                mv ${file}.part ${file}
            fi
        done
    done
    # advance date to the date of the last entry in the feed
    DATE=${updated}
done
