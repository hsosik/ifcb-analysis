#!/bin/sh
# find blob bins that have yet to be computed and staged to demi
# this script is designed to run on demi
find /data/vol1/IFCB* -name '*.roi' -exec sh check_for_blobs.sh {} \;
find /data/vol3/IFCB* -name '*.roi' -exec sh check_for_blobs.sh {} \;