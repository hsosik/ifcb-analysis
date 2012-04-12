import re
import os
from ifcb.io.pids import parse_id

# FIXME hardcoded path
blob_years='/data/vol4/blobs'

def lid(pid):
    return parse_id(pid).as_lid

def year(pid):
    return parse_id(pid).year

def year_day(pid):
    return parse_id(pid).yearday

def zipname(pid):
    return lid(pid)+'_blobs_v2.zip'

def dest(pid):
    return os.path.join(blob_years,year(pid),year_day(pid),zipname(pid))

def local_exists(bin_pid):
    return os.path.exists(dest(bin_pid))

def local_deposit(bin_pid,zipfile):
    dest_file = dest(bin_pid)
    try:
        os.makedirs(os.path.dirname(dest_file))
    except:
        pass
    shutil.move(zipfile,dest_file)
