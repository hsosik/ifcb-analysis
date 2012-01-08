#!/bin/sh
find /scratch/ifcb/2007/2007_086/* -name '*.zip' -exec python enqueue_blobfix.py {} \;
