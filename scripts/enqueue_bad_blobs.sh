#!/bin/sh
find /scratch/ifcb/2010 -name '*.zip' -exec python enqueue_blobfix.py {} \;
