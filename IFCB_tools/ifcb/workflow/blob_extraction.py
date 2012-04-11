import sys
import re
import os
from oii.ifcb import client
from oii.workflow.rabbit import Job, WIN, PASS, FAIL, SKIP
from oii.matlab import Matlab
import shutil

MATLAB_PATH=[
'/home/ifcb/trunk/feature_extraction',
'/home/ifcb/trunk/feature_extraction/blob_extraction',
'/home/ifcb/trunk/webservice_tools',
'/home/ifcb/trunk/dipum_toolbox_2.0.1'
]

tmp_dir='/home/ifcb/test_out'
blob_years='/data/vol4/blobs'

# FIXME use ifcb.io.pids
# FIXME only supports <=MVCO id format
def lid(pid):
    return re.sub(r'.*/','',pid)

def year(pid):
    (t,i,y,j) = re.split(r'[:/_]+',pid)[2:6]
    return y

def year_day(pid):
    (t,i,y,j) = re.split(r'[:/_]+',pid)[2:6]
    return '%s_%s' % (y,j)

def zipname(pid):
    return lid(pid)+'_blobs_v2.zip'

def dest(pid):
    return os.path.join(blob_years,year(pid),year_day(pid),zipname(pid))

class BlobExtraction(Job):
    def run_callback(self,message):
        def selflog(line):
            self.log(line)
        bin_pid = message
        dest_file = dest(bin_pid)
        if os.path.exists(dest_file):
            self.log('SKIPPING %s - already present in destination directory' % bin_pid)
            return SKIP
        tmp_file = os.path.join(tmp_dir, zipname(bin_pid))
        matlab = Matlab('/usr/bin/matlab',MATLAB_PATH,output_callback=selflog)
        cmd = 'bin_blobs(\'%s\',\'%s\')' % (bin_pid, tmp_dir)
        matlab.run(cmd)
        selflog('staging completed blob zip to %s' % dest_file)
        try:
            os.makedirs(os.path.dirname(dest_file))
        except:
            pass
        shutil.move(tmp_file,dest_file)
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
