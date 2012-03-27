import json
from urllib2 import urlopen, Request
import ifcb
from ifcb.io import Timestamped
from ifcb.io.path import Resolver
from ifcb.io import TARGET_INFO
import re
from ifcb.io.pids import parse_id
import urllib2 as urllib
from PIL import Image
from cStringIO import StringIO

def get_json(pid):
    print 'fetching ' + pid + '.json'
    return json.loads(''.join(urlopen(Request(pid + '.json'))))

class Target(object):
    info = None
    pid = None
    bin = None
    
    def __init__(self, pid, bin=None, info=None):
        self.pid = pid
        self.bin = bin
        self.info = info
        
    def __getattribute__(self,name):
        if name in TARGET_INFO:
            return self.info[name]
        elif name == 'info':
            if object.__getattribute__(self,'info') is None:
                self.info = get_json(object.__getattribute__(self,'pid'))
            return object.__getattribute__(self,'info')
        elif name == 'bin':
            if object.__getattribute__(self,'bin') is None:
                self.bin = Bin(self.binID)
            return self.bin
        else:
            return object.__getattribute__(self,name)
        
    def image(self):
        img_file = urllib.urlopen(self.pid+'.png')
        return Image.open(StringIO(img_file.read()))

class Bin(Timestamped):
    bin_info = None # dict containing information about the bin
    
    def __init__(self, pid, info=None):
        self.pid = pid
        #self.instrument = self.info()['instrument']

    def __repr__(self):
        return '{Bin ' + self.pid + '}'

    def info(self):
        if self.bin_info is None:
            self.bin_info = get_json(self.pid+'/full')
        return self.bin_info

    def properties(self,include_pid=False):
        props = self.info().copy()
        del props['targets']
        if not include_pid:
            del props['pid']
        return props
    
    def headers(self):
        return self.properties()
    
    # generate all targets
    def __iter__(self):
        for t in self.info()['targets']:
            yield Target(t['pid'], self, t)
            
    def all_targets(self):
        return list(self)

    # retrieve the nth target (1-based!)
    # more efficient than subscripting the result of all_targets
    def target(self,n):
        for target in self:
            if n == target.targetNumber:
                return target
    
    # return number of targets
    def length(self):
        return length(self.all_targets())
    
    ## image access
    def all_images(self):
        for target in self:
            yield target.image()
        
    # convenience method for getting a specific image
    def image(self,n):
        return self.target(n).image()

    # compute the pid of a target, given its index
    def target_pid(self,target_number):
        return self.target(n).targetNumber

class Client(Resolver):
    def latest_bins(self,n=10):
        feed = get_json('http://ifcb-data.whoi.edu/feed')
        length = min(len(feed),n)
        return [Bin(info['pid']) for info in feed[:length]]
    
    def latest_bin(self):
        """Return latest bin"""
        return self.latest_bins(1)[0]
    
    def resolve(self,pid):
        oid = parse_id(pid)
        if oid.isbin:
            return Bin(pid)
        elif oid.istarget:
            return Target(pid)
        # FIXME add day dir
        raise KeyError('unrecognized pid '+pid)
