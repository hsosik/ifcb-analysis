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

def __layout(bin, (width, height), size, sort_key, page=0):
    """Fit images into a rectangle using a bin packing algorithm. Returns structures
    describing the layout.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    targets = sorted(bin.all_targets(), key=sort_key)
    targetpid2layout = {}
    current_page = 0
    for current_page in range(0,page+1):
        packer = JimScottRectanglePacker(width, height)
        for target in targets:
            if target.pid not in targetpid2layout:
                h = target.info[WIDTH] # rotate 90 degrees
                w = target.info[HEIGHT] # rotate 90 degrees
                if h * w >= size:
                    p = packer.TryPack(w,h)
                    if p is not None:
                        layout = {'x':p.x, 'y':p.y, WIDTH:w, HEIGHT:h, PID:target.info[PID], TARGET_NUMBER:target.info[TARGET_NUMBER]}
                        targetpid2layout[target.pid] = { 'page': current_page, 'layout': layout }
    for entry in targetpid2layout.values():
        if entry['page'] == page:
            yield entry['layout']

def layout(bin, (width, height), size=0, sort_key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH]), page=0):
    """Fit images into a rectangle using a bin packing algorithm. Returns structures
    describing the layout.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    tiles = list(__layout(bin, (width, height), size, sort_key, page))
    return {'width':width, 'height':height, 'tiles':tiles}
    
def mosaic(bin, (width, height), size=0, existing_layout=None, page=0):
    """Fit images into a rectangle using a bin packing algorithm. Returns an image.
    
    Parameters:
    bin - the bin to get the images from (instance of BinFile)
    (width, height) - the pixel dimensions of the desired mosaic
    size - size threshold in pixels^2. images below this area threshold will be ignored"""
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    if existing_layout is None:
        existing_layout = layout(bin, (width, height), size, page=page)
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

def http(bin, fullarea, size_thresh, wh, out, format, page=0):
    try:
        m = mosaic(bin, fullarea, size=size_thresh, page=page)
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
def doit(pid,size='medium',format='jpg',headers=True,out=sys.stdout,fs_roots=FS_ROOTS,page=0):
    format = dict(png='png', jpg='jpeg', gif='gif', json='json')[format] # validate
    # sizes map to widths, widths map to height via fixed 16:9 aspect ratio
    tw = {'icon':48, 'thumb':128, 'small':320, 'medium':800, 'large':1024, '720p':1280, '1080p':1920, 'max':2400}[size]
    wh = box(tw,ASPECT_RATIO)
    size_thresh = 1200
    try:
        bin = Filesystem(fs_roots).resolve(pid) # fetch the bin
        # all mosaics are created at 2400 x 1260 and then scaled down
        fullarea = box(2400,ASPECT_RATIO)
        if format == 'json': # if the caller just wants the layout
            if headers:
                for h in ['Content-type: application/json',
                          'Cache-control: max-age=31622400',
                          '']:
                    print h
            json.dump(layout(bin, fullarea, size_thresh, page=page),out) # give it to em
        else:
            if headers:
                cache_key = ifcb.lid(pid) + '/mz/p'+str(page)+'/'+str(tw)+'.'+format
                cache_io(cache_key, lambda o: http(bin, fullarea, size_thresh, wh, o, format, page=page), out)
            else:
                stream(thumbnail(mosaic(bin,fullarea,size_thresh,page=page),wh),out,format)
    except KeyError:
        print 'Status: 404\n'

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
    #doit('http://ifcb-data.whoi.edu/test/IFCB5_2012_212_204100','medium','json',0)
    pid = cgi.FieldStorage().getvalue('pid')
    size = cgi.FieldStorage().getvalue('size','medium')
    page = int(cgi.FieldStorage().getvalue('page','0'))
    format = cgi.FieldStorage().getvalue('format','jpg')
    doit(pid,size,format,page=page)
