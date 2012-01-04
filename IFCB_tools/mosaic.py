#!/usr/bin/python
# create a mosaic image containing multiple ROI's from the given bin
from PIL import Image
from ifcb.binpacking import JimScottRectanglePacker

import ifcb
from ifcb.io.file import BinFile
from ifcb.io.path import Filesystem
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER, PID
from config import FS_ROOTS, DATA_TTL
from ifcb.io.cache import cache_io, cache_obj

import sys
import os.path
import cgi
import cgitb
import re
import shutil
import tempfile
import json

ASPECT_RATIO=0.5625

"""Create a mosaic of images from the an IFCB bin"""

def __layout(bin, (width, height), sort_key, size=0):
    """Fit images into a rectangle using a bin packing algorithm. Returns structures
    describing the layout.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    packer = JimScottRectanglePacker(width, height)
    """Sort by largest first. This does not generate a "representative" mosaic, but one
    that shows large and therefore interesting targets in a layout without much wasted space"""
    targets = sorted(bin.all_targets(), key=sort_key)
    for target in targets:
        h = target.info[WIDTH] # rotate 90 degrees
        w = target.info[HEIGHT] # rotate 90 degrees
        if w * h > size: # above the size threshold?
            p = packer.TryPack(w, h) # attempt to fit
            if p is not None:
                yield {'x':p.x, 'y':p.y, WIDTH:w, HEIGHT:h, PID:target.info[PID], TARGET_NUMBER:target.info[TARGET_NUMBER]}

def layout(bin, (width, height), size=0, sort_key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH])):
    """Fit images into a rectangle using a bin packing algorithm. Returns structures
    describing the layout.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    cache_key = ifcb.lid(bin.pid) + '/mosaic/'+str(width)+'x'+str(height)+'.json' # cache the layout
    tiles = cache_obj(cache_key, lambda: list(__layout(bin, (width, height), sort_key, size)))
    return {'width':width, 'height':height, 'tiles':tiles}
    
def mosaic(bin, (width, height), size=0, existing_layout=None):
    """Fit images into a rectangle using a bin packing algorithm. Returns an image.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    if existing_layout is None:
        existing_layout = layout(bin, (width, height), size)
    for entry in existing_layout['tiles']:
        mosaic.paste(bin.target(entry[TARGET_NUMBER]).image(), (entry['x'], entry['y']))
    return mosaic
           
def thumbnail(image, wh):
    image.thumbnail(wh, Image.ANTIALIAS)
    return image

def stream(image,out,format):
    with tempfile.SpooledTemporaryFile() as flo:
        image.save(flo,format)
        flo.seek(0)
        shutil.copyfileobj(flo, out)

def box(w,aspectratio):
    return (w, int(w * aspectratio))

def http(bin, fullarea, size_thresh, wh, out, format):
    try:
        m = mosaic(bin, fullarea, size_thresh)
        # FIXME should print to out
        for h in ['Content-type: image/'+format,
                  'Cache-control: max-age=%d' % DATA_TTL,
                  '']:
            print >>out, h
        return stream(thumbnail(m, wh), out, format)
    except IOError:
        for h in ['Status: 500 Filesystem busy',
                  'Cache-control: max-age=1',
                  '']:
            print h
        raise IOError

# entry point.
def doit(pid,size='medium',format='jpg',headers=True,out=sys.stdout,fs_roots=FS_ROOTS):
    format = dict(png='png', jpg='jpeg', gif='gif', json='json')[format] # validate
    # sizes map to widths, widths map to height via fixed 16:9 aspect ratio
    tw = {'icon':48, 'thumb':128, 'small':320, 'medium':800, 'large':1024, '720p':1280, '1080p':1920, 'max':2400}[size]
    wh = box(tw,ASPECT_RATIO)
    size_thresh = 1200
    bin = Filesystem(fs_roots).resolve(pid) # fetch the bin
    # all mosaics are created at 2400 x 1260 and then scaled down
    fullarea = box(2400,ASPECT_RATIO)
    if format == 'json': # if the caller just wants the layout
        if headers:
            for h in ['Content-type: application/json',
                      'Cache-control: max-age=31622400',
                      '']:
                print h
        json.dump(layout(bin, fullarea, size_thresh),out) # give it to em
    else:
        if headers:
            cache_key = ifcb.lid(pid) + '/mosaic/'+str(tw)+'.'+format
            cache_io(cache_key, lambda o: http(bin, fullarea, size_thresh, wh, o, format), out)
        else:
            stream(thumbnail(mosaic(bin,fullarea,size_thresh),wh),out,format)

def save_mosaic(bin,outfile=None,format='PNG',size=2400):
    if len(sys.argv) > 2:
        outfile = sys.argv[2]
    m = mosaic(bin, box(size, ASPECT_RATIO))
    if outfile is not None:
        with open(outfile,'wb') as out:
            stream(m,out,format)
    else:
       stream(m,sys.stdout,format)

if __name__=='__main__':
    cgitb.enable()
    pid = cgi.FieldStorage().getvalue('pid')
    size = cgi.FieldStorage().getvalue('size','medium')
    format = cgi.FieldStorage().getvalue('format','jpg')
    doit(pid,size,format)
