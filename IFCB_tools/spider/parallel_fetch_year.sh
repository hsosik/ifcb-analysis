#!/bin/bash
YEAR=$1
NTHREADS=$2
for i in $(seq 1 $NTHREADS); do
    nohup bash fetch_year.sh $YEAR $i $NTHREADS &
done