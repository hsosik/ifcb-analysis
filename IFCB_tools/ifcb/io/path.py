from ifcb.io.dir import YearsDir, DayDir
from ifcb.io.file import BinFile
from ifcb.io import ADC_EXT
import ifcb
import re
import os.path

class Filesystem:
    years_dirs = []
    
    def __init__(self,years_dirs):
        self.years_dirs = [YearsDir(d) for d in years_dirs]

    def all_days(self):
        for years in years_dirs:
            for day in years:
                yield day
                
    def all_bins(self):
        for day in self.all_days():
            for bin in day:
                yield bin
    
    def all_targets(self):
        for bin in self.all_bins():
            for target in bin:
                yield target
    
    # given the pid of a day, return the day e.g.,
    # http://ifcb-data.whoi.edu/IFCB1_2010_025
    # would be located at
    # {some years dir}/IFCB1_2010_025
    def day(self,pid):
        lid = ifcb.lid(pid)
        for years in self.years_dirs:
            day_path = os.path.join(years.dir, lid)
            if os.path.exists(day_path):
                return DayDir(day_path)
            
    # given the pid of a bin, return the bin, e.g.,
    # http://ifcb-data.whoi.edu/IFCB1_2010_025_134056
    # would be located at
    # {some years dir}/IFCB1_2010_025/IFCB1_2010_025_134056
    def bin(self,pid):
        lid = ifcb.lid(pid)
        (bin, day) = re.match(r'((IFCB\d+_\d{4}_\d{3})_\d{6})',lid).groups() 
        for years in self.years_dirs:
            bin_path = os.path.join(years.dir, day, bin) + '.' + ADC_EXT
            # test for existence of ADC path, should check other paths too
            if os.path.exists(bin_path):
                return BinFile(bin_path)
            
    # given the pid of a target, return the target_info
    def target(self,pid):
        (target, bin_lid, target_no) = re.match(r'((IFCB\d+_\d{4}_\d{3}_\d{6})_(\d+))',ifcb.lid(pid)).groups()
        bin = self.bin(ifcb.pid(bin_lid))
        return bin.target(int(target_no)) # bin.target is 0-based
         
    # TODO way of finding bins within a given time range
            