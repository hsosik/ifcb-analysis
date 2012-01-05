#!/bin/sh
domain=whoi.edu
for host in pixel voxel texel; do
    fqdn=${host}.${domain}
    ONE="s/ /','${fqdn}','bin_blobs','/"
    TWO="s/^/insert into logs (ts,host,log,message) values (timestamp with time zone '/"
    THREE="s/$/');/"
    echo find /scratch/ifcb/blobs -name log.txt -exec cat {} \\\; | ssh ${fqdn} | grep ^20 | sed  -e "$ONE" -e "$TWO" -e "$THREE"
done
