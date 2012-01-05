#!/bin/sh
sh blob_progress.sh | awk 'BEGIN { print "3 k 0 0 s1 s2" }; {print "L1",$3,"+ s1 L2",$5,"+ s2"}; END { print "L1 L2 / p"}' | dc
