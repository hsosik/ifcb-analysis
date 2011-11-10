import csv
import ifcb
from ifcb.io import adc_path, roi_path, hdr_path, ADC_SCHEMA, ADC_COLUMNS, HDR_SCHEMA, HDR_COLUMNS, TARGET_NUMBER, BIN_ID, PID, WIDTH, HEIGHT, BYTE_OFFSET, Timestamped, CONTEXT, FRAME_GRAB_TIME, ISO_8601_FORMAT, TARGET_INFO
from PIL import Image, ImageChops
from array import array
import string
import re
import os
import os.path
import time
import calendar
import pickle
from cache import cache_io, cache_obj, cache_file
from config import STITCH
from ifcb.io.stitching import StitchedBin

"""Parsing of IFCB data formats including header files, metadata, and imagery"""

# a target
class Target(object):
    """Represents a Target (e.g., an image and metadata from a single ROI)"""
    info = {}
    bin = None

    def __init__(self,target_info,bin):
        self.bin = bin
        self.info = target_info
    
    def __getattribute__(self,name):
        if name in TARGET_INFO:
            return self.info[name]
        else:
            return object.__getattribute__(self,name)
        
    def __repr__(self):
        return '{Target '+self.pid + '}'
    
    def time(self):
        bin_time = calendar.timegm(self.bin.time()) # bin seconds since epoch
        return time.gmtime(bin_time + self.frameGrabTime)
    
    def iso8601time(self):
        return time.strftime(ISO_8601_FORMAT, self.time())
    
    def image(self):
        return self.bin.image(self.targetNumber)
    
# one bin's worth of data
class BinFile(Timestamped):
    """Represents a ~20-minute bin of data including all targets. This is where the code for
    parsing the raw data files lives"""
    id = ''
    dir = ''
    time_format = '%Y_%j_%H%M%S'
    
    # determine PID, local id, instrument number, and timestamp from path
    def __init__(self, path):
        self.dir = os.path.dirname(os.path.abspath(path))
        file = os.path.basename(path)
        (self.id, ext) = os.path.splitext(file)
        # the timestamp is the approximate time the syringe was sampled and flow began
        self.time_string = re.sub('^IFCB\\d+_','',self.id)
        self.pid = ifcb.pid(self.id)
        self.instrument = re.sub(r'^IFCB(\d+)_.*',r'\1',self.id)
    
    def __repr__(self):
        return '{Bin ' + self.pid + '}'
    
    @property
    def adc_path(self):
        return adc_path(self.id,self.dir)
    
    @property
    def roi_path(self):
        return roi_path(self.id,self.dir)
    
    @property
    def hdr_path(self):
        return hdr_path(self.id,self.dir)

    def properties(self,include_pid=False):
        props = self.headers()
        props['instrument'] = self.instrument
        props['time'] = self.iso8601time
        if include_pid:
            props['pid'] = self.pid
        return props
    
    def headers(self):
        cache_key = self.__cache_key('hdr')
        lines = [line.rstrip() for line in cache_file(cache_key, self.hdr_path).readlines()]
        # "context" is what the text on lines 2-4 is called in the header file
        props = { CONTEXT: [lines[n].strip('"') for n in range(3)] }
        # add an "instrument" property
        props['instrument'] = self.instrument # FIXME move to properties
        # now handle format variants
        if len(lines) >= 6: # don't fail on original header format
            columns = re.split(' +',re.sub('"','',lines[4])) # columns of metadata in CSV format
            values = re.split(' +',re.sub(r'[",]',' ',lines[5]).strip()) # values of those columns in CSV format
            # for each column take the string and cast it to the schema's column type
            for (column, (name, cast), value) in zip(HDR_COLUMNS, HDR_SCHEMA, values):
                props[name] = cast(value)
        return props
    
    def __cache_key(self,subkey=None,id=None):
        if id is None:
            id = self.id
        if subkey is not None:
            id = '_'.join([id,str(subkey)])
        return id
    
    # the ADC file is in CSV format, schema is described in ADC_SCHEMA
    def __read_adc(self, open_adc_file=None):
        cache_key = self.__cache_key('adc')
        target_number = 1
        for row in csv.reader(cache_file(cache_key, self.adc_path)):
            # record some contextual information that we know; the targeg number, the bin's id, and the target pid
            target_info = { TARGET_NUMBER: target_number, BIN_ID: self.pid, PID: self.target_pid(target_number) }
            # now cast the column values to their corresponding type in the schema
            for (name, cast), value in zip(ADC_SCHEMA, row):
                target_info[name] = cast(value)
            # skip 0x0 targets ...
            if target_info[HEIGHT] > 0 and target_info[WIDTH] > 0:
                target = Target(target_info,self)
                yield target
            # ... but count them, so indicies are correct
            target_number = target_number + 1
            
    # generate all targets
    def __iter__(self):
        return iter(self.__read_adc())
            
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
        count = 0
        for target in self:
            count = count + 1
        return count
    
    # image data for all the targets is stored in the ROI file
    def __get_image_bytes(self, target, open_roi_file=None):
        if open_roi_file is None:
            roi_file = open(self.roi_path,'rb',1)
        else:
            roi_file = open_roi_file
        roi_file.seek(target.byteOffset)
        # images are 8-bit grayscale
        data = array('B')
        data.fromfile(roi_file, target.width * target.height)
        if open_roi_file is None:
            roi_file.close()
        return data
        
    def __get_image(self, target, roi_file=None):
        cache_key = self.__cache_key('img',ifcb.lid(target.pid))
        data = cache_obj(cache_key, lambda: self.__get_image_bytes(target, roi_file))
        im = Image.fromstring('L', (target.height, target.width), data) # rotate 90 degrees
        return im
    
    ## image access
    def all_images(self):
        with open(self.roi_path(),'rb',1) as roi_file:
            for target in self:
                yield self.__get_image(target.info, roi_file)
        
    # convenience method for getting a specific image
    def image(self,n,roi_file=None):
        return self.__get_image(self.target(n),roi_file)

    # compute the pid of a target, given its index
    def target_pid(self,target_number):
        return '%s_%05d' % (self.pid, target_number)
    
    def save_images(self,outdir='.',format='PNG'):
        # read target info from the ADC file
        with open(self.roi_path(),'rb',1) as roi_file:
            target_number = 1
            for target in self:
                if(target.width > 0 and target.height > 0): # IFCB writes (or used to write) some 0x0 target's; skip them
                    im = self.__get_image(target, roi_file)
                    # output filename is {id}_ddddd where ddddd is target number in file
                    outfile = os.path.join(outdir,'%s_%05d.%s' % (self.id, target_number, string.lower(format)))
                    im.save(outfile, format)
                    target_number = target_number + 1 # increment this number *outside* of the loop that skips 0x0 targets!
                    
def newBin(path):
    if STITCH:
        return StitchedBin(BinFile(path))
    else:
        return BinFile(path)
        
