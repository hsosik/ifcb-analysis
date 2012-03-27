from ifcb.io.dir import YearsDir, DayDir
from ifcb.io.file import newBin
from ifcb.io import ADC_EXT
import ifcb
import re
import os.path
from cache import cache_obj
import calendar
import math
from ifcb.io.pids import parse_id

"""Resolution of IFCB global identifiers to local filesystem paths"""

class Resolver:
    """Resolve a pid to some object"""
    def resolve(self,pid):
        return None

class Filesystem(Resolver):
    """Represents a filesystem containing one or more "years" directories which themselves
    contain zero or more day directories. The hierarchy is
    
    /{year directory}/{day directory}/{bin}.[adc,hdr,roi]
    
    and the corresponding object hierarchy is
    
    Filesystem -> YearsDir -> DayDir -> Bin -> Target
    """
    years_dirs = []
    
    def __init__(self,years_dirs):
        """
        Parameters:
        years_dirs - 'root' directories containing day directories
        """
        self.years_dirs = [YearsDir(os.path.abspath(d)) for d in years_dirs]

    def all_days(self):
        """Yield all day directories (returns DayDir instances)"""
        for years in self.years_dirs:
            for day in years:
                yield day

    def __within(self,start,end,timestamped):    
        if start is None and end is None:
            return True
        else:
            t = timestamped.epoch_time
            if start is None:
                return t <= calendar.timegm(end)
            elif end is None:
                return t >= calendar.timegm(start)
            else:
                return t <= calendar.timegm(end) and t >= calendar.timegm(start)
        return True
    
    def __nearest_thing(self,things,date,exclude=False):
        nearest_thing = None
        min_delta = 31622400000000 # 1,000 years
        epoch_time = calendar.timegm(date)
        for thing in things:
            delta = math.fabs(thing.epoch_time - epoch_time)
            if delta < min_delta and not(exclude and delta == 0):
                min_delta = delta
                nearest_thing = thing
        return nearest_thing
            
    def nearest_bin(self,date):
        """Return the bin whose timestamp is nearest to this date"""
        window = 1 # 1-day
        epoch_time = calendar.timegm(date)
        while window < 365250: # 1000 years
            for day in self.all_days():
                delta = math.fabs(day.epoch_time - epoch_time)
                if delta < (window * 86400): # within {window} days?
                    for bin in sorted(list(day.all_bins()),key=lambda b: abs(b.epoch_time - epoch_time)):
                        if bin.epoch_time < epoch_time:
                            return bin
            window *= 2
        
    def all_bins(self,start=None,end=None):
        """Yield all bins
        
        Parameters:
        start - return bins no earlier than this date (default: None)
        end - return bins no later than this date (default: None)
        
        yields Bin instances"""
        for day in self.all_days():
            if self.__within(start,end,day):
                for bin in day:
                    if self.__within(start,end,bin):
                        yield bin

    def latest_days(self,n=10):
        """Return latest days as of now.
        
        Parameters:
        n - number of days to return
        
        Returns DayDir instances"""
        return sorted(list(self.all_days()), key=lambda day: day.time)[-n:]

    def latest_day(self):
        """Return latest day.
        
        Return a DayDir instance"""
        return self.latest_days(1)[0]

    def latest_bins(self,n=10,nd=2):
        """Return latest bins as of now.
        
        Parameters:
        n - number of bins to return
        
        Returns Bin instances"""
        bins = []
        for day in self.latest_days(nd):
            for bin in day:
                bins.append(bin)
        return sorted(bins, key=lambda bin: bin.time)[-n:]

    def latest_bin(self):
        """Return latest bin"""
        return self.latest_bins(1)[0]
                
    def all_targets(self):
        """Yield all targets.
        
        Warning: this is a very, very, very expensive operation"""
        for bin in self.all_bins():
            for target in bin:
                yield target
    
    def day(self,pid):
        """given the pid of a day, return the day e.g.,
        http://ifcb-data.whoi.edu/IFCB1_2010_025
        would be located at
        {some years dir}/IFCB1_2010_025"""
        return self.__day(pid)
    
    # search for a day in the filesystem
    def __day(self,pid):
        lid = ifcb.lid(pid) # local id
        for years in self.years_dirs: # search the years dirs
            day_path = os.path.join(years.dir, lid) # compute the day path
            if os.path.exists(day_path): # if it exists
                return DayDir(day_path) # construct a DayDir to represent it
        raise KeyError('day '+pid+' not found')
            
    def bin(self, pid):
        """given the pid of a bin, return the bin, e.g.,
        http://ifcb-data.whoi.edu/IFCB1_2010_025_134056
        would be located at
        {some years dir}/IFCB1_2010_025/IFCB1_2010_025_134056"""
        bin_path = self.bin_path(pid)
        if bin_path is not None:
            return newBin(bin_path)

    # search for a bin in the filesystem
    def bin_path(self,pid):
        oid = parse_id(pid)
        tried = []
        for path in oid.paths([yd.dir for yd in self.years_dirs]):
            bin_path = path + '.' + ADC_EXT
            tried += [bin_path]
            if os.path.exists(bin_path):
                return bin_path
        raise KeyError('no path to bin '+pid+ (' '.join(tried)))
            
    # given the pid of a target, return the target_info
    def target(self,pid):
        return self.__target(pid)
    
    def __target(self,pid):
        oid = parse_id(pid)
        bin = self.bin(ifcb.pid(oid.bin_lid))
        return bin.target(int(oid.target)) # bin.target is 0-based
    
    def resolve(self,pid):
        """Resolve a pid in this filesystem"""
        oid = parse_id(pid)
        if oid.isday:
            return self.day(pid)
        elif oid.isbin:
            return self.bin(pid)
        elif oid.istarget:
            return self.target(pid)
        raise KeyError('unrecognized pid '+pid)
        
    # TODO way of finding bins within a given time range
