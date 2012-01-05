#!/bin/sh
for host in pixel voxel texel; do
    echo 'bash feature_extraction/blob_extraction/show_progress.sh' | ssh $host 2>&1 | grep Processing
done
