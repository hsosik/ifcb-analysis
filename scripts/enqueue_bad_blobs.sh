#!/bin/sh
find /scratch/ifcb/20* -name '*.zip' -exec python enqueue_blobfix.py {} \;
