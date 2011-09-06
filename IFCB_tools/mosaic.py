#!/usr/bin/python
# create a mosaic image containing multiple ROI's from the given bin
from PIL import Image
from ifcb.binpacking import JimScottRectanglePacker

import ifcb
from ifcb.io.file import BinFile
from ifcb.io.path import Filesystem
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER, PID
from config import FS_ROOTS
from ifcb.io.cache import cache_io

import sys
import os.path
import cgi
import cgitb
import re
import shutil
import tempfile
import json

def layout(bin, (width, height), size=0):
    packer = JimScottRectanglePacker(width, height)
    targets = sorted(bin.all_targets(), key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH]))
    for target in targets:
        h = target.info[WIDTH] # rotate 90 degrees
        w = target.info[HEIGHT] # rotate 90 degrees
        if w * h > size:
            p = packer.TryPack(w, h)
            if p is not None:
                yield {'x':p.x, 'y':p.y, PID:target.info[PID], TARGET_NUMBER:target.info[TARGET_NUMBER]}
    
def mosaic(bin, (width, height), size=0):
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    for entry in layout(bin, (width, height), size):
        mosaic.paste(bin.image(entry[TARGET_NUMBER]), (entry['x'], entry['y']))
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

def doit(pid,size='medium',format='jpg',fs_roots=FS_ROOTS):
    format = dict(png='png', jpg='jpeg', gif='gif', json='json')[format] # validate
    aspectratio = 0.5625 # 16:9
    tw = {'icon':48, 'thumb':128, 'small':320, 'medium':800, 'large':1024, '720p':1280, '1080p':1920}[size]
    wh = box(tw,aspectratio)
    size_thresh = 2500
    bin = Filesystem(fs_roots).resolve(pid)
    if format == 'json':
        print 'Content-type: application/json\n'
        json.dump(list(layout(bin, wh, size_thresh)),sys.stdout)
    else:
        print 'Content-type: image/'+format+'\n'
        cache_key = ifcb.lid(pid) + '/badge/'+str(tw)+'.'+format
        fullarea = box(2400,aspectratio)
        cache_io(cache_key, lambda o: stream(thumbnail(mosaic(bin, fullarea, 2500),wh),o,format), sys.stdout)

if __name__=='__main__':
    cgitb.enable()
    pid = cgi.FieldStorage().getvalue('pid')
    size = cgi.FieldStorage().getvalue('size','medium')
    format = cgi.FieldStorage().getvalue('format','jpg')
    doit(pid,size,format)
