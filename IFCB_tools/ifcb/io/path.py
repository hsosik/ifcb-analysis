from ifcb.io.dir import YearsDir, DayDir
from ifcb.io.file import BinFile
from ifcb.io import ADC_EXT
import ifcb
import re
import os.path

"""Resolution of IFCB global identifiers to local filesystem paths"""

mc = None

def memcached():
    if mc is None:
        mc = pylibmc.Client(["127.0.0.1"], binary=True)
    return mc
        

class Filesystem:
    years_dirs = []
    
    def __init__(self,years_dirs):
        self.years_dirs = [YearsDir(os.path.abspath(d)) for d in years_dirs]

    def all_days(self):
        for years in self.years_dirs:
            for day in years:
                yield day
                
    def all_bins(self):
        for day in self.all_days():
            for bin in day:
                yield bin

    def latest_days(self,n=10):
        return sorted(list(self.all_days()), key=lambda day: day.time())[-n:]

    def latest_day(self):
        return self.latest_days(1)[0]

    def latest_bins(self,n=10):
        bins = []
        for day in self.latest_days(2):
            for bin in day:
                bins.append(bin)
        return sorted(bins, key=lambda bin: bin.time())[-n:]

    def latest_bin(self):
        return self.latest_bins(1)[0]
                
    def latest_bin(self):
        latest_day = sorted(list(self.all_days()), key=lambda day: day.time())[-1]
        return sorted(latest_day.all_bins(), key=lambda bin: bin.time())[-1]
                
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
    
    def resolve(self,pid):
        lid = ifcb.lid(pid)
        if re.match(r'^IFCB\d+_\d{4}_\d{3}$',lid): # day
            return self.day(pid)
        elif re.match(r'^IFCB\d+_\d{4}_\d{3}_\d{6}$',lid): # bin
            return self.bin(pid)
        elif re.match(r'^IFCB\d+_\d{4}_\d{3}_\d{6}_\d+$',lid):
            return self.target(pid)
        
    # TODO way of finding bins within a given time range
