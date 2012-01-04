#!/bin/sh
DIR=/mnt/queenrose/train_04Nov2011_fromWebServices/
DATA_NAMESPACE=http://ifcb-data.whoi.edu/mvco/
echo Content-type: text/csv
echo
find $DIR -maxdepth 2 -name '*.png' | sed -e "s#^$DIR##" -e "s#/#,$DATA_NAMESPACE#" -e 's/.png//'

