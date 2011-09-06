#!/usr/bin/python
# create a mosaic image containing multiple ROI's from the given bin
from PIL import Image
from ifcb.binpacking import JimScottRectanglePacker

import ifcb
from ifcb.io.file import BinFile
from ifcb.io.path import Filesystem
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER
from config import FS_ROOTS
from ifcb.io.cache import cache_io

import sys
import os.path
import cgi
import cgitb
import re
import shutil
import tempfile

def mosaic(bin, (width, height), size=0):
    mosaic = Image.new('L', (width, height))
    mosaic.paste(160,(0,0,width,height))
    packer = JimScottRectanglePacker(width, height)
    targets = sorted(bin.all_targets(), key=lambda t: 0 - (t.info[HEIGHT] * t.info[WIDTH]))
    good = 0
    bad = 0
    for target in targets:
        h = target.info[WIDTH] # rotate 90 degrees
        w = target.info[HEIGHT] # rotate 90 degrees
        if w * h > size:
            p = packer.TryPack(w, h)
            if p is not None:
                good = good + 1
                mosaic.paste(target.image(), (p.x, p.y))
            else:
                bad = bad + 1
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

if __name__=='__main__':
    cgitb.enable()
    size = cgi.FieldStorage().getvalue('size','medium')
    format = cgi.FieldStorage().getvalue('format','jpg')
    aspectratio = 0.5625 # 16:9
    tw = {'icon':48, 'thumb':128, 'small':320, 'medium':800, 'large':1024, '720p':1280, '1080p':1920}[size]
    wh = box(tw,aspectratio)
    pid = cgi.FieldStorage().getvalue('pid')
    format = dict(png='png', jpg='jpeg', gif='gif')[format] # validate
    print 'Content-type: image/'+format+'\n'
    bin = Filesystem(FS_ROOTS).resolve(pid)
    cache_key = ifcb.lid(pid) + '/badge/'+str(tw)+'.'+format
    fullarea = box(2400,aspectratio)
    cache_io(cache_key, lambda o: stream(thumbnail(mosaic(bin, fullarea, 2500),wh),o,format), sys.stdout)
