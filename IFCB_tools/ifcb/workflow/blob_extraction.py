import sys
import re
import os
from blob_storage import lid, dest, zipname
from oii.ifcb import client
from oii.workflow.rabbit import Job, WIN, PASS, FAIL, SKIP
from ifcb.workflow.blob_deposit import BlobDeposit
from oii.matlab import Matlab
import shutil

# FIXME hardcoded paths
MATLAB_BASE='/home/jfutrelle/ifcb/trunk'
MATLAB_DIRS=[
'feature_extraction',
'feature_extraction/blob_extraction',
'webservice_tools',
'dipum_toolbox_2.0.1'
]

MATLAB_PATH=[os.path.join(MATLAB_BASE,pc) for pc in MATLAB_DIRS]

# FIXME hardcoded
MATLAB_EXEC_PATH='/usr/local/MATLAB/R2011b/bin/matlab'

tmp_dir='/home/jfutrelle/ifcb/test_out'

class BlobExtraction(Job):
    def run_callback(self,message):
        def selflog(line):
            self.log(line)
        bin_pid = message
        dest_file = dest(bin_pid)
        if (self.deposit is not None and self.deposit.exists(bin_pid)) or os.path.exists(dest_file):
            self.log('SKIPPING %s - already present in destination directory' % bin_pid)
            return SKIP
        tmp_file = os.path.join(tmp_dir, zipname(bin_pid))
        matlab = Matlab(MATLAB_EXEC_PATH,MATLAB_PATH,output_callback=selflog)
        cmd = 'bin_blobs(\'%s\',\'%s\')' % (bin_pid, tmp_dir)
        matlab.run(cmd)
        selflog('staging completed blob zip to %s' % dest_file)
        if self.deposit is not None:
            self.deposit.deposit(bin_pid,tmp_file)
            os.remove(tmp_file)
        else:
            local_deposit(bin_pid,tmp_file)
    def enqueue_feed(self,namespace,n=4):
        feed = client.list_bins(namespace=namespace,n=n)
        for bin in feed:
            bin_pid = bin['pid']
            dest_file = dest(bin_pid)
            work_dir = os.path.join(tmp_dir, lid(bin_pid))
            if os.path.exists(work_dir):
                print 'SKIPPING %s - found temporary files at %s' % (bin_pid, work_dir)
            elif os.path.exists(dest_file):
                print 'SKIPPING %s - found completed blob zip at %s' % (bin_pid, dest_file)
            else:
                print 'queueing %s' % bin_pid
                self.enqueue(bin_pid)

if __name__=='__main__':
    job = BlobExtraction('blob_extraction',host='demi.whoi.edu')
    job.deposit = BlobDeposit('http://demi.whoi.edu:5000')
    command = sys.argv[1]
    if command == 'q':
        for pid in sys.argv[2:]:
            job.enqueue(pid)
    elif command == 'log':
        job.consume_log()
    elif command == 'w':
        job.work(True)
    elif command == 'r':
        job.retry_failed()
    elif command == 'cron':
        job.enqueue_feed(namespace='http://ifcb-data.whoi.edu/mvco/')
