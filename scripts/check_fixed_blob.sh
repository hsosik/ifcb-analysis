#!/bin/sh
# script to validate a fixed blob zip
# checks that
# 1. the zip contains a csv file, xml file, and receipt.txt
# 2. the zip contains more than zero png files (if there are zero, it may not be a bug, but that is expensive to check)
zipfile=$1
n=`unzip -l $zipfile | grep -e 'csv' -e 'xml' -e 'receipt.txt' | wc -l`
if [ ! $n -eq 3 ]; then
    echo FAIL $zipfile csv/xml/receipt check failed
fi
n=`unzip -l $zipfile | grep -e 'png' | wc -l`
if [ $n -eq 0 ]; then
    echo WARN $zipfile contains no .png files
fi