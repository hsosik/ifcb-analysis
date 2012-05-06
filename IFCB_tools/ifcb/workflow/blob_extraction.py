import sys
import re
import os
from blob_storage import BlobStorage
from oii.ifcb import client
from oii.utils import gen_id
from oii.times import iso8601
from oii.config import get_config
from oii.workflow.rabbit import Job, JobExit, WIN, PASS, FAIL, SKIP, DIE
from ifcb.workflow.blob_deposit import BlobDeposit
from oii.matlab import Matlab
import shutil
import platform

CHECK_EVERY = 200

MATLAB_DIRS=[
'feature_extraction',
'feature_extraction/blob_extraction',
'webservice_tools',
'dipum_toolbox_2.0.1'
]

class BlobExtraction(Job):
    def __init__(self, config):
        self.configure(config)
        super(BlobExtraction,self).__init__(self.config.amqp_queue, self.config.amqp_host)
    def configure(self, config):
        self.config = config
        self.config.matlab_path = [os.path.join(self.config.matlab_base, md) for md in MATLAB_DIRS]
        self.deposit = BlobDeposit(self.config.blob_deposit)
        self.storage = BlobStorage(self.config)
    def exists(self,bin_pid):
        return (self.deposit is not None and self.deposit.exists(bin_pid)) or os.path.exists(self.storage.dest(bin_pid))
    def preflight(self):
        for p in self.config.matlab_path:
            assert os.path.exists(p)
        assert os.path.exists(self.config.tmp_dir)
        try:
            tempfile = os.path.join(self.config.tmp_dir,gen_id()+'.txt')
            with open(tempfile,'w') as tf:
                tf.write('test')
                tf.flush()
            assert os.path.exists(tempfile)
            os.remove(tempfile)
            assert not os.path.exists(tempfile)
        except:
            raise
    def run_callback(self,message):
        jobid = gen_id()[:5]
        def selflog(line):
            self.log('%s %s' % (jobid, line))
        def self_check_log(line,bin_pid):
            selflog(line)
            self.output_check -= 1
            if self.output_check <= 0:
                if self.exists(bin_pid):
                    selflog('STOPPING JOB - %s completed by another worker' % bin_pid)
                    raise JobExit(bin_pid, SKIP)
                self.output_check = CHECK_EVERY
        bin_pid = message
        dest_file = self.storage.dest(bin_pid)
        if self.exists(bin_pid):
            selflog('SKIPPING %s - already completed' % bin_pid)
            return SKIP
        job_dir = os.path.join(self.config.tmp_dir, gen_id())
        try:
            os.makedirs(job_dir)
        except:
            selflog('WARNING cannot create temporary directory %s' % job_dir)
        tmp_file = os.path.join(job_dir, self.storage.zipname(bin_pid))
        matlab = Matlab(self.config.matlab_exec_path,self.config.matlab_path,output_callback=lambda l: self_check_log(l, bin_pid))
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
                selflog('NOT SAVING - blobs for %s already present at output destination' % bin_pid)
        except KeyboardInterrupt:
            selflog('KeyboardInterrupt, requeueing job before exit')
            return DIE
        finally:
            try:
                shutil.rmtree(job_dir)
            except:
                selflog('WARNING cannot remove temporary directory %s' % job_dir)
    def enqueue_feed(self,n=4):
        feed = client.list_bins(namespace=self.config.namespace,n=n)
        for bin in feed:
            bin_pid = bin['pid']
            #if not should_skip(bin_pid):
            print 'queueing %s' % bin_pid
            self.enqueue(bin_pid)

if __name__=='__main__':
    timeseries = sys.argv[1]
    config = get_config('./blob.conf',timeseries)
    job = BlobExtraction(config)
    job.preflight()
    command = sys.argv[2]
    if command == 'q':
        for pid in sys.argv[3:]:
            job.enqueue(pid)
    elif command == 'log':
        job.consume_log()
    elif command == 'w':
        job.work(True)
    elif command == 'r':
        job.retry_failed(filter=lambda x: len(x)>3)
    elif command == 'cron':
        job.enqueue_feed(n=25)
