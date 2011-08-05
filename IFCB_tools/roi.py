#!/usr/bin/python
from PIL import Image
from array import array
import string
import re
import adc
from adc import all_rois, nth_roi
import os

"""Access to image data from ROI files"""

# currently requires corresponding ADC file in same directory as ROI files

# low-level function for fetching ROI image based on ADC description
# roi_info - ADC structure returned by ADC utilities (e.g., load_adc)
# roi_file - an open ROI file
def get_image(roi_info, roi_file):
    width = roi_info[adc.WIDTH]
    height = roi_info[adc.HEIGHT]
    offset = roi_info[adc.BYTE_OFFSET]
    roi_file.seek(offset+1) # byte offsets in ROI file are 1-based (Matlab legacy)
    data = array('B')
    data.fromfile(roi_file, width * height)
    im = Image.new('L', (height, width)) # rotate 90 degrees
    im.putdata(data)
    return im
    
# return a list of paths; the adc file path, the roi file path, and the hdr file path,
# given an id of a bin and a dir containing the files
def paths(id, dir):
    return [os.path.join(dir,id) + '.' + ext for ext in ('adc', 'roi', 'hdr')]

# id - id of bin (e.g., IFCB1_2009_0034_134025)
# dir - dir containing ROI and ADC files
# outdir - directory to put resulting image files
# format - format of images (any format suppported by PIL)
def batch_convert(id, dir, outdir = '.', format = 'PNG'):
    (adc_path, roi_path, hdr_path) = paths(id,dir)
    roi_file = open(roi_path,'rb')
    roi_number = 1
    # read ROI info from the ADC file
    for roi_info in all_rois(adc_path):
        width = roi_info[adc.WIDTH]
        height = roi_info[adc.HEIGHT]
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
    (adc_path, roi_path, hdr_path) = paths(id,dir)
    roi_file = open(roi_path,'rb')
    for roi_info in all_rois(adc_path):
        yield get_image(roi_info, roi_file)
        
# convenience method for getting an image from a specific bin and index    
# id - id of bin (e.g., IFCB6_20010_0321_004523)
# dir - dir containing ROI and ADC files
def nth_image(id, index, dir='.'):
    (adc_path, roi_path, hdr_path) = paths(id,dir)
    roi_file = open(roi_path,'rb')
    return get_image(nth_roi(adc_path,index), roi_file)