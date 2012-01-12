#!/bin/sh
# this script can be invoked by cron. if no matlab instance is running, it will run
# the day_blobs script on any day that has not had any blobs extracted.
# if for some reason there's an unfinished day, this will not finish the day; that will
# need to be handled separately

day_dir=$1

# set MATLABPATH to include blob/feature extraction code
SOURCE_DIR=/home/jfutrelle/trunk
export MATLABPATH=${SOURCE_DIR}/feature_extraction:${SOURCE_DIR}/feature_extraction/blob_extraction:${SOURCE_DIR}/webservice_tools

# dir containing year directories
DATA_DIR=/scratch/ifcb/redo

# matlab executable
MATLAB=/usr/local/MATLAB/R2011b/bin/matlab

log() {
    echo `date +%Y-%m-%dT%H:%M:%S%Z` $*
}

log Checking that Matlab is idle ...

# check for running Matlab jobs
procs=`ps aux | grep MATLAB | grep -v grep | wc -l | awk '{print $1}'`
if [ $procs = '0' ]; then
    out_dir=`echo $day_dir | sed -e 's#redo/#redo/blobs/#'`
    # create the output directory
    log creating $out_dir
    mkdir -p $out_dir
    # start the matlab job and log its output
    nohup ${MATLAB} -nodisplay -r "try, day_blobs('${day_dir}','${out_dir}'), catch, end, quit" >> ${out_dir}/log.txt &
else
    log Matlab already running
fi