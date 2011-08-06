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
def path(id, ext, dir='.'):
    return os.path.join(dir,id) + '.' + ext

def adc_path(id,dir='.'):
    return path(id,ADC_EXT,dir)
def roi_path(id,dir='.'):
    return path(id,ROI_EXT,dir)
def hdr_path(id,dir='.'):
    return path(id,HDR_EXT,dir)

# one bin's worth of data
class Bin:
    id = ''
    dir = ''
    
    def __init__(self, id, dir='.'):
        self.id = id
        self.dir = dir
    
    def adc_path(self):
        return adc_path(id,dir)
    
    def roi_path(self):
        return roi_path(id,dir)
    
    def hdr_path(self):
        return hrd_path(id,dir)

# return dict of paths; the adc file path, the roi file path, and the hdr file path,
# given an id of a bin and a dir containing the files
def paths(id, dir='.'):
    exts = ['adc','roi','hdr']
    return dict(zip(exts, [path(id,ext,dir) for ext in exts]))

# load the ROI's as structs; this is a generator so may need to be wrapped in a call to list()
def all_rois(file):
    reader = csv.reader(open(file,'rb'))
    for row in reader:
        roi = {}
        for (name, cast), value in zip(adc_schema, row):
            roi[name] = cast(value)
        yield roi

# efficiently retrieve the nth ROI from an ADC file (0-based!)
def nth_roi(file,n):
    rois = load_adc(file)
    while(n > 0):
        rois.next()
        n = n - 1
    return rois.next()

def length(file):
    count = 0
    for roi in load_adc(file):
        count = count + 1
    return count


"""Access to image data from ROI files"""

# currently requires corresponding ADC file in same directory as ROI files

# low-level function for fetching ROI image based on ADC description
# roi_info - ADC structure returned by ADC utilities (e.g., load_adc)
# roi_file - an open ROI file
def get_image(roi_info, roi_file):
    width = roi_info[WIDTH]
    height = roi_info[HEIGHT]
    offset = roi_info[BYTE_OFFSET]
    roi_file.seek(offset+1) # byte offsets in ROI file are 1-based (Matlab legacy)
    data = array('B')
    data.fromfile(roi_file, width * height)
    im = Image.new('L', (height, width)) # rotate 90 degrees
    im.putdata(data)
    return im

# id - id of bin (e.g., IFCB1_2009_0034_134025)
# dir - dir containing ROI and ADC files
# outdir - directory to put resulting image files
# format - format of images (any format suppported by PIL)
def batch_convert(id, dir='.', outdir = '.', format = 'PNG'):
    roi_file = open(roi_path(id,dir),'rb')
    roi_number = 1
    # read ROI info from the ADC file
    for roi_info in all_rois(adc_path(id,dir)):
        width = roi_info[WIDTH]
        height = roi_info[HEIGHT]
        if(width > 0 and height > 0): # IFCB writes (or used to write) some 0x0 ROI's; skip them
            im = get_image(roi_info, roi_file)
            # output filename is {id}_ddddd where ddddd is ROI number in file
            outfile = os.path.join(outdir,'%s_%05d.%s' % (id, roi_number, string.lower(format)))
            im.save(outfile, format)
        roi_number = roi_number + 1 # increment this number *outside* of the loop that skips 0x0 rois!

# convenience method returning all images
# id - id of bin (e.g., IFCB6_20010_0321_004523)
# dir - dir containing ROI and ADC files
def all_images(id, dir='.'):
    roi_file = open(roi_path(id,dir),'rb')
    for roi_info in all_rois(adc_path(id,dir)):
        yield get_image(roi_info, roi_file)
        
# convenience method for getting an image from a specific bin and index    
# id - id of bin (e.g., IFCB6_20010_0321_004523)
# dir - dir containing ROI and ADC files
def nth_image(id, index, dir='.'):
    roi_file = open(roi_path(id,dir),'rb')
    return get_image(nth_roi(adc_path(id,dir),index), roi_file)