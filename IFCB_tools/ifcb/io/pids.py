import re
import ifcb
import os

# FIXME #1202
import config

def no_day_dirs():
    try:
        return 'NO_DAY_DIRS' in dir(config) and config.NO_DAY_DIRS
    except:
        return False

class OldPid(object):
    def __init__(self,pid,namespace=None):
        self.lid = ifcb.lid(pid,namespace)
        self.date_format = '%Y_%j'
        self.datetime_format = '%Y_%j_%H%M%S'
    def mod(self,regex,what='ID'):
        """match or die"""
        try:
            return re.match(regex,self.lid).groups()[0]
        except:
            raise KeyError('unrecognized %s in IFCB ID: %s' % (what,self.lid))
    @property
    def instrument_number(self):
        return self.mod(r'.*IFCB(\d+).*','instrument number')
    @property
    def instrument_name(self):
        return self.mod(r'.*(IFCB\d+).*','instrument name')
    @property
    def year(self):
        return self.mod(r'^IFCB\d+_(\d{4})','year')
    @property
    def yearday(self):
        return self.mod(r'^IFCB\d+_(\d{4}_\d{3})','year/day')
    @property
    def day(self):
        return self.mod(r'^IFCB\d+_\d{4}_(\d{3})','day')
    @property
    def datetime(self):
        return self.mod(r'^IFCB\d+_(\d{4}_\d{3}_\d{6})','datetime')
    @property
    def target(self):
        return self.mod(r'^IFCB\d+_\d{4}_\d{3}_\d{6}_(\d+)','target')
    @property
    def isday(self):
        return re.match(r'^IFCB\d+_\d{4}_\d{3}$',self.lid)
    @property
    def isbin(self):
        return re.match(r'^IFCB\d+_\d{4}_\d{3}_\d{6}$',self.lid)
    @property
    def istarget(self):
        return re.match(r'^IFCB\d+_\d{4}_\d{3}_\d{6}_\d+$',self.lid)
    @property
    def day_lid(self):
        if self.isday:
            return self.lid
        else:
            return re.sub(r'(^IFCB\d+_\d{4}_\d{3}).*',r'\1',self.lid)
    @property
    def bin_lid(self):
        if self.isbin:
            return self.lid
        else:
            return re.sub(r'(^IFCB\d+_\d{4}_\d{3}_\d{6}).*',r'\1',self.lid)
    @property
    def as_lid(self):
        return self.lid
    @property
    def as_pid(self):
        return ifcb.pid(self.lid)
    def paths(self,basedirs=['.']):
        """Given a bin ID, generate candidate paths, in order of likelihood"""
        if no_day_dirs():
            bin = re.match(r'.*(IFCB\d+_\d{4}_\d{3}_\d{6})',self.lid).groups()[0]
            for basedir in basedirs:
                yield os.path.join(basedir, bin)
            return
        else:
            (bin, day) = re.match(r'.*((IFCB\d+_\d{4}_\d{3})_\d{6})',self.lid).groups() 
            for basedir in basedirs:
                yield os.path.join(basedir, day, bin)
        # OK, that failed. maybe it's in a previous day
        (instrument, year, doy) = (self.instrument_name, int(self.year), int(self.day))
        if doy < 2 or doy > 364:
            for basedir in basedirs:
                for yesteryear, yesterday in ((year, ((doy - 2) % 365) + 1),
                                              (year-1, ((doy - 2) % 365) + 1),
                                              (year, ((doy - 2) % 366) + 1),
                                              (year-1, ((doy - 2) % 366) + 1)):
                    day = '%s_%d_%03d' % (instrument, yesteryear, yesterday)
                    yield os.path.join(basedir, day, bin)
    def __repr__(self):
        return ifcb.pid(self.lid)

class NewPid(OldPid):
    def __init__(self,pid,namespace=None):
        self.lid = ifcb.lid(pid,namespace)
        self.date_format = '%Y%m%d'
        self.datetime_format = '%Y%m%dT%H%M%S'
    @property
    def year(self):
        return self.mod(r'^D(\d{4})','year')
    @property
    def yearday(self):
        return self.mod(r'^D(\d{8})','year/day')
    @property
    def day(self):
        return self.mod(r'^D\d{4}(\d{4})','day')
    @property
    def datetime(self):
        return self.mod(r'^D(\d{8}T\d{6})','datetime')
    @property
    def target(self):
        return self.mod(r'^D\d{8}T\d{6}_IFCB\d+_(\d+)$','target')
    @property
    def isday(self):
        return re.match(r'^D\d{8}$',self.lid)
    @property
    def isbin(self):
        return re.match(r'D\d{8}T\d{6}_IFCB\d+$',self.lid)
    @property
    def istarget(self):
        return re.match(r'^D\d{8}T\d{6}_IFCB\d+_\d+$',self.lid)
    @property
    def day_lid(self):
        if self.isday:
            return self.lid
        else:
            return re.sub(r'(^D\d{8}).*',r'\1',self.lid)
    @property
    def bin_lid(self):
        if self.isbin:
            return self.lid
        elif self.istarget:
            return re.sub(r'_\d+$','',self.lid)
        else:
            return re.sub(r'(^D\d{8}T\d{6}).*',r'\1',self.lid)
    @property
    def as_lid(self):
        return self.lid
    @property
    def as_pid(self):
        return ifcb.pid(self.lid)
    def paths(self,basedirs=['.']):
        """Given a bin ID, generate candidate paths, in order of likelihood"""
        (bin, day, instrument_name) = re.match(r'.*((D\d{8})T\d{6}).*(IFCB\d+)',self.lid).groups() 
        for basedir in basedirs:
            yield os.path.join(basedir, day, '%s_%s' % (bin, instrument_name))
        # FIXME deal with "new year bug"

def parse_id(pid,namespace=None):
    lid = ifcb.lid(pid,namespace)
    # attempt to guess format
    if re.match(r'^IFCB',lid):
        return OldPid(lid)
    elif re.match(r'D.*IFCB\d+_?\d*$',lid):
        return NewPid(lid)
    elif re.match(r'^D\d+$',lid): # day dir in new format
        return NewPid(lid)
    else:
        raise KeyError('unrecognized ID format %s' % lid)

if __name__=='__main__':
    #pid = parse_id('IFCB4_1973_004_231422')
    #pid = parse_id('D21120403T121314_IFCB010')
    pid = parse_id('D20120325')
    print pid
    if pid.isday:
        print 'is day'
    print 'instrument = ' + pid.instrument_name
    print 'year = ' + pid.year
    print 'yearday = ' + pid.yearday
    print 'day = ' + pid.day
    print 'datetime = ' + pid.datetime
    for path in pid.paths(['foo','bar']):
        print path
    print 'target = ' + pid.target


    
