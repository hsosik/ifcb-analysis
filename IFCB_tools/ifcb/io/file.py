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
from config import STITCH, MOD_ROOTS
from ifcb.io.stitching import StitchedBin
from ifcb.io.pids import parse_id
import mmap

"""Parsing of IFCB data formats including header files, metadata, and imagery"""

# a target
class Target(object):
    """Represents a Target (e.g., an image and metadata from a single ROI)"""
    info = {}
    bin = None

    def __init__(self,target_info,bin):
        self.bin = bin
        self.info = target_info
        self.info['stitched'] = 0
    
    def __getattribute__(self,name):
        if name in TARGET_INFO:
            return self.info[name]
        else:
            return object.__getattribute__(self,name)
        
    def __repr__(self):
        return '{Target '+self.pid + '}'

    @property
    def lid(self):
        return ifcb.lid(self.pid)
        
    def time(self):
        bin_time = calendar.timegm(self.bin.time()) # bin seconds since epoch
        return time.gmtime(bin_time + self.frameGrabTime)
    
    def iso8601time(self):
        return time.strftime(ISO_8601_FORMAT, self.time())
    
    def image(self,roi_file=None):
        return self.bin.target_image(self,roi_file)
    
# one bin's worth of data
class BinFile(Timestamped):
    """Represents a ~20-minute bin of data including all targets. This is where the code for
    parsing the raw data files lives"""
    id = ''
    dir = ''
    __corrected_adc_path = None

    # determine PID, local id, instrument number, and timestamp from path
    def __init__(self, path):
        self.dir = os.path.dirname(os.path.abspath(path))
        file = os.path.basename(path)
        (self.id, ext) = os.path.splitext(file)
        # the timestamp is the approximate time the syringe was sampled and flow began
        self.pid = ifcb.pid(self.id)
        self.oid = parse_id(self.id)
        self.time_string = self.oid.datetime
        self.instrument = self.oid.instrument_number
        self.time_format = self.oid.datetime_format
    
    def __repr__(self):
        return '{Bin ' + self.pid + '}'
    
    @property
    def lid(self):
        return self.id
    
    @property
    def raw_adc_path(self):
        return adc_path(self.id,self.dir)

    @property
    def adc_path(self):
        if self.__corrected_adc_path is not None:
            return self.__corrected_adc_path
        else:
            for r in MOD_ROOTS:
                dd = self.oid.day_lid
                p = os.path.join(r,dd,self.id + '.adc.mod')
                if os.path.exists(p):
                    self.__corrected_adc_path = p
                    return p
            self.__corrected_adc_path = self.raw_adc_path
            return self.__corrected_adc_path
    
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
        with open(self.hdr_path,'r') as hdr:
            lines = [line.rstrip() for line in hdr]
        props = {}
        # add an "instrument" property
        props['instrument'] = self.instrument # FIXME move to properties
        if lines[0] == 'Imaging FlowCytobot Acquisition Software version 2.0; May 2010':
            props = { CONTEXT: [lines[0]] } # FIXME parse
        elif re.match(r'^softwareVersion:',lines[0]):
            props = { CONTEXT: [lines[0]] } # FIXME parse
        else:
            # "context" is what the text on lines 2-4 is called in the header file
            props = { CONTEXT: [lines[n].strip('"') for n in range(3)] }
            # now handle format variants
            if len(lines) >= 6: # don't fail on original header format
                columns = re.split(' +',re.sub('"','',lines[4])) # columns of metadata in CSV format
                values = re.split(' +',re.sub(r'[",]',' ',lines[5]).strip()) # values of those columns in CSV format
                # for each column take the string and cast it to the schema's column type
                for (column, (name, cast), value) in zip(HDR_COLUMNS, HDR_SCHEMA, values):
                    props[name] = cast(value)
        return props
    
    def __parse_row(self,row,target_number):
        # record some contextual information that we know; the targeg number, the bin's id, and the target pi
        target_info = { TARGET_NUMBER: target_number, BIN_ID: self.pid, PID: self.target_pid(target_number) }
        # now cast the column values to their corresponding type in the schema
        for (name, cast), value in zip(ADC_SCHEMA, row):
            target_info[name] = cast(value)
        return target_info
    
    # the ADC file is in CSV format, schema is described in ADC_SCHEMA
    def __read_adc(self, skip=0):
        adcfile = self.adc_path
        with open(adcfile,'r') as adc:
            for i in range(skip):
                adc.readline()
            target_number = skip + 1
            for row in csv.reader(adc):
                target_info = self.__parse_row(row,target_number)
                # skip 0x0 targets ...
                if target_info[HEIGHT] > 0 and target_info[WIDTH] > 0:
                    target = Target(target_info,self)
                    yield target
                # ... but count them, so indicies are correct
                target_number = target_number + 1

    def iterate(self,skip=0):
        return iter(self.__read_adc(skip))
                
    # generate all targets
    def __iter__(self):
        return self.iterate()
    
    def all_targets(self):
        return list(self)

    # retrieve the nth target (1-based!)
    # more efficient than subscripting the result of all_targets
    def target(self,n):
        for target in self.__read_adc(n-1):
            if n == target.targetNumber:
                return target
            if target.targetNumber > n:
                raise KeyError
    
    def targets(self,ns):
        skip = min(ns) - 1
        for target in self.__read_adc(skip):
            if target.targetNumber in ns:
                yield target
            if target.targetNumber > max(ns):
                return
                
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
        data = self.__get_image_bytes(target, roi_file)
        im = Image.fromstring('L', (target.height, target.width), data) # rotate 90 degrees
        return im
    
    ## image access
    def all_images(self):
        with open(self.roi_path,'rb',1) as roi_file:
            for target in self:
                yield self.__get_image(target.info, roi_file)
        
    # convenience method for getting a specific image
    def image(self,n,roi_file=None):
        return self.__get_image(self.target(n),roi_file)
    
    # used by target to fetch image
    def target_image(self,target,roi_file=None):
        return self.__get_image(target,roi_file)

    # compute the pid of a target, given its index
    def target_pid(self,target_number):
        return '%s_%05d' % (self.pid, target_number)
    
    def save_images(self,outdir='.',format='PNG'):
        # read target info from the ADC file
        with open(self.roi_path,'rb',1) as roi_file:
            for target in self:
                if(target.width > 0 and target.height > 0): # IFCB writes some 0x0 target's; skip them
                    im = self.__get_image(target, roi_file)
                    # output filename is {id}_ddddd where ddddd is target number in file
                    outfile = os.path.join(outdir,'%s_%05d.%s' % (self.id, target.targetNumber, string.lower(format)))
                    im.save(outfile, format)

def newBin(path):
    if STITCH:
        return StitchedBin(BinFile(path))
    else:
        return BinFile(path)
        
