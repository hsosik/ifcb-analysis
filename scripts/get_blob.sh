#!/bin/sh
# this script depends on passwordless authz to pixel/voxel/texel
pid=$1
outdir=$2
tmpdir=/tmp/blobs
mkdir -p $tmpdir
mkdir -p $outdir
bin=`echo $pid | sed -e 's/_[0-9]*$//'`
day=`echo $bin | sed -e 's/IFCB._//' -e 's/_[0-9]*$//'`
year=`echo $day | sed -e 's/IFCB._//' -e 's/_[0-9]*$//'`
file=${bin}_blobs.zip
path=/scratch/ifcb/blobs/$year/$day/$file
case $year in
2006)
	host=texel
	;;
2007)
	host=voxel
	;;
2008)
	host=voxel
	;;
2009)
	host=pixel
	;;
2010)
	host=pixel
	;;
2011)
	host=texel
	;;
esac
if [ ! -e $tmpdir/$file ]; then
    scp jfutrelle@${host}:${path} $tmpdir
fi
if [ ! -e $outdir/${pid}.png ]; then
    unzip -d $outdir -o $tmpdir/$file ${pid}.png
fi


