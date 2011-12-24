#!/bin/bash
NTHREADS=5
for i in $(seq 1 $NTHREADS); do
    nohup bash fetch_year.sh $i $NTHREADS &
done