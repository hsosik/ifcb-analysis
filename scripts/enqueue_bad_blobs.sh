#!/bin/sh
find /scratch/ifcb/20* -name '*.zip' | python enqueue_blobfix.py {} \;
