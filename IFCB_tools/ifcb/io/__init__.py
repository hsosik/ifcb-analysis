import csv
from PIL import Image
from array import array
import string
import re
import os

# define constants for use with ROI structs

# adc columns, 0-based. "x" is horizontal, "y" is vertical, x left to right, y bottom to top
TRIGGER = 'trigger'
PROCESSING_END_TIME = 'processingEndTime'
FLUORESENCE_HIGH = 'fluorescenceHigh'
FLUORESCENCE_LOW = 'fluorescenceLow'
SCATTERING_HIGH = 'scatteringHigh'
SCATTERING_LOW = 'scatteringLow'
COMPARATOR_PULSE = 'comparatorPulse'
TRIGGER_OPEN_TIME = 'triggerOpenTime'
FRAME_GRAB_TIME = 'frameGrabTime'
# location of ROI in camera field in pixels
BOTTOM = 'bottom'
LEFT = 'left'
# ROI extent in pixels
HEIGHT = 'height'
WIDTH = 'width'
# ROI byte offset
BYTE_OFFSET = 'byteOffset'
VALVE_STATUS = 'valveStatus'

adc_schema = [(TRIGGER, int),
          (PROCESSING_END_TIME, float),
          (FLUORESENCE_HIGH, float),
          (FLUORESCENCE_LOW, float),
          (SCATTERING_HIGH, float),
          (SCATTERING_LOW, float),
          (COMPARATOR_PULSE, float),
          (TRIGGER_OPEN_TIME, float),
          (FRAME_GRAB_TIME, float),
          (BOTTOM, int),
          (LEFT, int),
          (HEIGHT, int),
          (WIDTH, int),
          (BYTE_OFFSET, int),
          (VALVE_STATUS, float)]

ADC_EXT = 'adc'
ROI_EXT = 'roi'
HDR_EXT = 'hdr'

# other handy property names
ROI_NUMBER = 'roiNumber' # 1-based index of ROI in bins
BIN_ID = 'binID' # bin ID
ROI_ID = 'roiID' # roi ID

# useful functions
def ext_path(id, ext, dir='.'):
    return os.path.join(dir,id) + '.' + ext

def adc_path(id,dir='.'):
    return ext_path(id,ADC_EXT,dir)
def roi_path(id,dir='.'):
    return ext_path(id,ROI_EXT,dir)
def hdr_path(id,dir='.'):
    return ext_path(id,HDR_EXT,dir)

# one bin's worth of data
class Bin:
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
        count = 1
        for row in reader:
            roi = { ROI_NUMBER: count, BIN_ID: self.id }
            for (name, cast), value in zip(adc_schema, row):
                roi[name] = cast(value)
            yield roi
            count = count + 1

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
