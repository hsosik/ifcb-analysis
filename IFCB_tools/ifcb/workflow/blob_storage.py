import re
import os
from ifcb.io.pids import parse_id

class BlobStorage(object):
    def __init__(self, config):
        self.config = config
    def lid(self, pid):
        """Local ID part of pathname based on configured namespace"""
        return parse_id(pid, self.config.namespace).as_lid
    def year(self, pid):
        """Year part of pathname based on configured namespace"""
        return parse_id(pid, self.config.namespace).year
    def year_day(self, pid):
        """Year/day dir path of pathname based on configured namespace"""
        return parse_id(pid, self.config.namespace).yearday
    def zipname(self, pid):
        """Name of zipfile"""
        return self.lid(pid)+'_blobs_v2.zip'
    def dest(self, pid):
        """Absolute path of zip file in filesystem according to configuration"""
        return os.path.join(self.config.blob_years,self.year(pid),self.year_day(pid),self.zipname(pid))
    def local_exists(self, bin_pid):
        """Does the zip file exist for this bin"""
        return os.path.exists(self.dest(bin_pid))
    def local_deposit(self, bin_pid, zipfile):
        """Copy a local file to its destination"""
        dest_file = self.storage.dest(bin_pid)
        try:
            os.makedirs(os.path.dirname(dest_file))
        except:
            pass
        shutil.move(zipfile,dest_file)
