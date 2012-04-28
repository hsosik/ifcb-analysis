import sys
import re
import os
from blob_storage import lid, dest, zipname
from oii.ifcb import client
from oii.utils import gen_id
from oii.times import iso8601
from oii.workflow.rabbit import Job, WIN, PASS, FAIL, SKIP, DIE
from ifcb.workflow.blob_deposit import BlobDeposit
from oii.matlab import Matlab
import shutil
import platform

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

tmp_dir='/scratch/tmp'

def is_done(bin_pid):
    dest_file = dest(bin_pid)
    return os.path.exists(dest_file)

def was_attempted(bin_pid):
    work_dir = os.path.join(tmp_dir, lid(bin_pid))
    return os.path.exists(work_dir)

def should_skip(bin_pid):
    if was_attempted(bin_pid):
        print 'SKIPPING %s - found temporary files' % bin_pid
        return True
    elif is_done(bin_pid):
        print 'SKIPPING %s - found completed blob zip' % bin_pid
        return True
    else:
        return False

def preflight():
    for p in MATLAB_PATH:
        assert os.path.exists(p)
    assert os.path.exists(tmp_dir)
    try:
        tempfile = os.path.join(tmp_dir,gen_id()+'.txt')
        with open(tempfile,'w') as tf:
            tf.write('test')
            tf.flush()
        assert os.path.exists(tempfile)
        os.remove(tempfile)
        assert not os.path.exists(tempfile)
    except:
        raise

CHECK_EVERY = 200

class BlobExtraction(Job):
    def exists(self,bin_pid):
        return (self.deposit is not None and self.deposit.exists(bin_pid)) or os.path.exists(dest(bin_pid))
    def run_callback(self,message):
        jobid = ('%s_%s' % (platform.node(), gen_id()))[:16]
        def selflog(line):
            self.log('%s %s %s' % (iso8601(), jobid, line))
        def self_check_log(line,bin_pid):
            selflog(line)
            self.output_check -= 1
            if self.output_check <= 0:
                if self.exists(bin_pid):
                    selflog('STOPPING JOB - completed by another worker')
                    raise
                self.output_check = CHECK_EVERY
        bin_pid = message
        dest_file = dest(bin_pid)
        if self.exists(bin_pid):
            selflog('SKIPPING %s - already completed' % bin_pid)
            return SKIP
        job_dir = os.path.join(tmp_dir, gen_id())
        try:
            os.makedirs(job_dir)
        except:
            selflog('WARNING cannot create temporary directory %s' % job_dir)
        tmp_file = os.path.join(job_dir, zipname(bin_pid))
        matlab = Matlab(MATLAB_EXEC_PATH,MATLAB_PATH,output_callback=lambda l: self_check_log(l, bin_pid))
        cmd = 'bin_blobs(\'%s\',\'%s\')' % (bin_pid, job_dir)
        try:
            self.output_check = CHECK_EVERY
            matlab.run(cmd)
            if not os.path.exists(tmp_file):
                selflog('WARNING bin_blobs succeeded but produced no output for %s' % bin_pid)
            elif not self.exists(bin_pid): # check to make sure another worker hasn't finished it in the meantime
                if self.deposit is not None:
                    selflog('DEPOSITING blob zip for %s to deposit service' % bin_pid)
                    self.deposit.deposit(bin_pid,tmp_file)
                else:
                    selflog('SAVING completed blob zip for %s to %s' % (bin_pid, dest_file))
                    local_deposit(bin_pid,tmp_file)
            else:
                selflog('NOT SAVING - blobs already present at output destination')
        except KeyboardInterrupt:
            selflog('KeyboardInterrupt, requeueing job before exit')
            return DIE
        finally:
            try:
                shutil.rmtree(job_dir)
            except:
                selflog('WARNING cannot remove temporary directory %s' % job_dir)
    def enqueue_feed(self,namespace,n=4):
        feed = client.list_bins(namespace=namespace,n=n)
        for bin in feed:
            bin_pid = bin['pid']
            #if not should_skip(bin_pid):
            print 'queueing %s' % bin_pid
            self.enqueue(bin_pid)

if __name__=='__main__':
    preflight()
    job = BlobExtraction('blob_extraction',host='demi.whoi.edu')
    job.deposit = BlobDeposit('http://demi.whoi.edu:5000')
    command = sys.argv[1]
    if command == 'q':
        for pid in sys.argv[2:]:
            job.enqueue(pid)
    elif command == 'rq':
        for pid in sys.argv[2:]:
            if not should_skip(pid):
                job.enqueue(pid)
    elif command == 'check':
        for pid in sys.argv[2:]:
            if not should_skip(pid):
                print 'TODO %s' % pid
    elif command == 'log':
        job.consume_log()
    elif command == 'w':
        job.work(True)
    elif command == 'r':
        job.retry_failed()
    elif command == 'cron':
        job.enqueue_feed(namespace='http://ifcb-data.whoi.edu/mvco/')
