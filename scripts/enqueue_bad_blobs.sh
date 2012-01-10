#!/bin/sh
find /scratch/ifcb/2009 -name '*.zip' -exec python enqueue_blobfix.py {} \;
