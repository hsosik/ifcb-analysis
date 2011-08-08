import csv
from ifcb import dataNamespace
from ifcb.io import adc_path, adc_schema, ROI_NUMBER, BIN_ID, PID
from PIL import Image
from array import array
import string
import re
import os

# one bin's worth of data
class RoiFile:
    id = ''
    dir = ''
    
    def __init__(self, id, dir='.'):
        self.id = id
        self.dir = dir
    
    def adc_path(self):
        return adc_path(self.id,self.dir)
    
    def roi_path(self):
        return roi_path(self.id,self.dir)
    
    def hdr_path(self):
        return hdr_path(self.id,self.dir)
    
    # generate all ROI's
    def all_rois(self):
        reader = csv.reader(open(self.adc_path(),'rb'))
        roi_number = 1
        for row in reader:
            roi = { ROI_NUMBER: roi_number, BIN_ID: self.id, PID: self.pid(roi_number) }
            for (name, cast), value in zip(adc_schema, row):
                roi[name] = cast(value)
            yield roi
            roi_number = roi_number + 1

    # retrieve the nth roi (0-based!)
    def nth_roi(self,n):
        rois = self.all_rois()
        while(n > 0):
            rois.next()
            n = n - 1
            return rois.next()

    # return number of rois
    def length(self):
        count = 0
        for roi in self.all_rois():
            count = count + 1
        return count
    
    def __get_image(self, roi_info, roi_file):
        width = roi_info[WIDTH]
        height = roi_info[HEIGHT]
        offset = roi_info[BYTE_OFFSET]
        roi_file.seek(offset+1) # byte offsets in ROI file are 1-based (Matlab legacy)
        data = array('B')
        data.fromfile(roi_file, width * height)
        im = Image.new('L', (height, width)) # rotate 90 degrees
        im.putdata(data)
        return im
    
    ## image access
    def all_images(self):
        roi_file = open(self.roi_path(),'rb')
        for roi_info in self.all_rois():
            yield get_image(roi_info, roi_file)
        
    # convenience method for getting a specific image
    def nth_image(self,n):
        roi_file = open(self.roi_path(),'rb')
        return self.__get_image(self.nth_roi(index), roi_file)
    
    def pid(self,roi_number=None):
        pid = ''.join([dataNamespace, self.id])
        if roi_number:
            return '%s_%05d' % (pid, roi_number)
        else:
            return pid
    
    def save_images(self,outdir='.',format='PNG'):
        # read ROI info from the ADC file
        roi_file = open(self.roi_path(),'rb')
        roi_number = 1
        for roi_info in self.all_rois():
            width = roi_info[WIDTH]
            height = roi_info[HEIGHT]
            if(width > 0 and height > 0): # IFCB writes (or used to write) some 0x0 ROI's; skip them
                im = self.__get_image(roi_info, roi_file)
                # output filename is {id}_ddddd where ddddd is ROI number in file
                outfile = os.path.join(outdir,'%s_%05d.%s' % (self.id, roi_number, string.lower(format)))
                im.save(outfile, format)
            roi_number = roi_number + 1 # increment this number *outside* of the loop that skips 0x0 rois!
