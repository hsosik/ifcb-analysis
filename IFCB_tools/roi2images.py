#!/usr/bin/python
import csv
from sys import argv
from PIL import Image
from array import array
import string
import re
import adc

def roi2images(id, dir, outdir = '.', format = 'PNG'):
    adc_path = '%s/%s.adc' % (dir,id)
    roi_path = '%s/%s.roi' % (dir,id)
    adc_reader = csv.reader(open(adc_path,'rb'))
    roi = open(roi_path,'rb')
    roi_number = 1
    for row in [[cast(cell) for cell, cast in zip(row, adc.ROW_TYPES)] for row in adc_reader]:
        width = row[adc.WIDTH]
        height = row[adc.HEIGHT]
        offset = row[adc.BYTE_OFFSET]
        if(width > 0 and height > 0):
            roi.seek(offset+1)
            data = array('B')
            data.fromfile(roi, width * height)
            im = Image.new('L', (height, width)) # rotate 90 degrees
            im.putdata(data)
            outfile = '%s/%s_%05d.%s' % (outdir, id, roi_number, string.lower(format))
            im.save(outfile, format)
        roi_number = roi_number + 1

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2images [id] [dir: .] [outdir: .] [format: png]'
    else:
        id = re.sub('(.*)\\.[a-z]+','\\1',argv[1])
        dir = '.'
        outdir = '.'
        format = 'PNG'
        arg = 2
        if(len(argv) > arg):
            dir = argv[arg]
            arg = arg + 1
        if(len(argv) > arg):
            outdir = argv[arg]
            arg = arg + 1
        if(len(argv) > arg):
            format = string.upper(argv[arg])
        roi2images(id, dir, outdir, format)
