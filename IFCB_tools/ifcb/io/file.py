import csv
import ifcb
from ifcb.io import adc_path, roi_path, hdr_path, ADC_SCHEMA, HDR_SCHEMA, HDR_COLUMNS, TARGET_NUMBER, BIN_ID, PID, WIDTH, HEIGHT, BYTE_OFFSET, Timestamped
from PIL import Image
from array import array
import string
import re
import os
import time

# one bin's worth of data
class BinFile(Timestamped):
    id = ''
    dir = ''
    time_format = '%Y_%j_%H%M%S'
    
    def __init__(self, id, dir='.'):
        self.id = id
        self.dir = dir
    
    def __repr__(self):
        return 'BinFile:' + self.id
        
    def adc_path(self):
        return adc_path(self.id,self.dir)
    
    def roi_path(self):
        return roi_path(self.id,self.dir)
    
    def hdr_path(self):
        return hdr_path(self.id,self.dir)
    
    def time_string(self):
        return re.sub('^IFCB\\d+_','',self.id)

    def instrument(self):
        return re.sub(r'^IFCB(\d+)_.*',r'\1',self.id)
    
    def headers(self):
        lines = [line.rstrip() for line in open(self.hdr_path(), 'r').readlines()]
        props = { 'context': [lines[n].strip('"') for n in range(3)] }
        props['instrument'] = self.instrument()
        if len(lines) >= 6: # don't fail on original header format
            columns = re.split(' +',re.sub('"','',lines[4]))
            values = re.split(' +',re.sub('[",]','',lines[5]).strip())
            for (column, (name, cast), value) in zip(HDR_COLUMNS, HDR_SCHEMA, values):
                props[name] = cast(value)
        return props
    
    # generate all target's
    def all_targets(self):
        reader = csv.reader(open(self.adc_path(),'rb'))
        target_number = 1
        for row in reader:
            target = { TARGET_NUMBER: target_number, BIN_ID: self.id, PID: self.pid(target_number) }
            for (name, cast), value in zip(ADC_SCHEMA, row):
                target[name] = cast(value)
            yield target
            target_number = target_number + 1

    # retrieve the nth target (0-based!)
    def target(self,n):
        targets = self.all_targets()
        while(n > 0):
            targets.next()
            n = n - 1
            return targets.next()

    # return number of targets
    def length(self):
        count = 0
        for target in self.all_targets():
            count = count + 1
        return count
    
    def __get_image(self, target_info, target_file):
        width = target_info[WIDTH]
        height = target_info[HEIGHT]
        offset = target_info[BYTE_OFFSET]
        target_file.seek(offset+1) # byte offsets in target file are 1-based (Matlab legacy)
        data = array('B')
        data.fromfile(target_file, width * height)
        im = Image.new('L', (height, width)) # rotate 90 degrees
        im.putdata(data)
        return im
    
    ## image access
    def all_images(self):
        roi_file = open(self.target_path(),'rb')
        for target_info in self.all_targets():
            yield self.__get_image(target_info, roi_file)
        
    # convenience method for getting a specific image
    def image(self,n):
        roi_file = open(self.target_path(),'rb')
        return self.__get_image(self.target(index), roi_file)
    
    def pid(self,target_number=None):
        pid = ifcb.pid(self.id)
        if target_number:
            return '%s_%05d' % (pid, target_number)
        else:
            return pid
    
    def save_images(self,outdir='.',format='PNG'):
        # read target info from the ADC file
        roi_file = open(self.roi_path(),'rb')
        target_number = 1
        for target_info in self.all_targets():
            width = target_info[WIDTH]
            height = target_info[HEIGHT]
            if(width > 0 and height > 0): # IFCB writes (or used to write) some 0x0 target's; skip them
                im = self.__get_image(target_info, roi_file)
                # output filename is {id}_ddddd where ddddd is target number in file
                outfile = os.path.join(outdir,'%s_%05d.%s' % (self.id, target_number, string.lower(format)))
                im.save(outfile, format)
            target_number = target_number + 1 # increment this number *outside* of the loop that skips 0x0 targets!
        
