from urllib2 import urlopen, Request
import json
from StringIO import StringIO
from PIL import Image, ImageDraw, ImageChops, ImageFilter
from collections import namedtuple
import math
from numpy import random
import ifcb

Roi = namedtuple('Roi', ['image','x','y','w','h', 'trigger'])

def get_image(pid):
    u = urlopen(pid + '.png')
    i = StringIO(u.read())
    u.close()
    return Image.open(i)

def get_image_properties(pid):
    return json.loads(''.join(urlopen(Request(pid + '.json'))))

def overlaps(t1, t2):
    if t1['trigger'] == t2['trigger']:
        (x11, y11) = (t1['left'], t1['bottom'])
        (x12, y12) = (x11 + t1['width'], y11 + t1['height'])
        (x21, y21) = (t2['left'], t2['bottom'])
        (x22, y22) = (x21 + t2['width'], y21 + t2['height'])
        # if (RectA.X1 < RectB.X2 && RectA.X2 > RectB.X1 &&
        #RectA.Y1 < RectB.Y2 && RectA.Y2 > RectB.Y1)
        if x11 < x22 and x12 > x21 and y11 < y22 and y12 > y21:
            return True
    return False

def find_pairs(bin_pid):
    bin = json.loads(''.join(urlopen(Request(bin_pid + '/full.json'))))
    prev = None
    for target in bin['targets']:
        if prev is not None and overlaps(target, prev):
            yield (prev['pid'], target['pid'])
        prev = target
            
def stitch(pids):
    rois = {}
    for pid in pids:
        p = get_image_properties(pid)
        print p
        i = get_image(pid)
        xywht = [p[x] for x in ['left','bottom','width','height','trigger']]
        rois[pid] = Roi._make([i] + xywht)
    x = min([roi.x for roi in rois.values()])
    y = min([roi.y for roi in rois.values()])
    w = max([roi.x + roi.w for roi in rois.values()]) - x
    h = max([roi.y + roi.h for roi in rois.values()]) - y
    s = Image.new('L',(h,w)) # the stitched image with a missing region
    mask = Image.new('L',(h,w), 255) # a mask of the missing region
    edges = Image.new('L',(h,w), 0) # just the edges of the missing region
    draw = ImageDraw.Draw(edges)
    for roi in rois.values():
        rx = roi.x - x
        ry = roi.y - y
        s.paste(roi.image, (ry, rx))
        mask.paste(0, (ry, rx, ry + roi.h, rx + roi.w))
        edges.paste(255, (ry, rx, ry + roi.h, rx + roi.w))
    for roi in rois.values():
        rx = roi.x - x
        ry = roi.y - y
        draw.rectangle((ry + 1, rx + 1, ry + roi.h - 2, rx + roi.w - 2), fill=0)
    draw.rectangle((0,0,h-1,w-1), outline=0)
    # OK. Now the stitched image contains both ROIs and black gap
    # The mask contains just the gap, in white
    # The edges is a mask just for the pixels bordering on the edge of the gap
    # compute the mean and variance of all of those pixels that aren't too dark (>150)
    sum = 0
    n = 0
    histogram = s.histogram(edges) # image pixel value, just along the edges
    low = 120 # arbitrary darkness cutoff: don't count edge pixels under this value
    for color in range(low,256):
        count = histogram[color]
        n += count
        sum += count * color
    mean = sum / n # mean pixel value along the edges (excluding dark pixels)
    sum2 = 0
    for color in range(low,256):
        sum2 += ((color - mean) ** 2) * histogram[color]
    variance = sum2 / n # corresponding variance
    # now fill the mask with the mean value, plus Gaussian noise
    pix = mask.load()
    noise = random.normal(math.sqrt(variance), size=(h,w))
    for x in xrange(h):
        for y in xrange(w):
            if pix[x,y] == 255: # only for pixels in the mask
                pix[x,y] = mean + noise[x,y]
    # apply a median filter to the noise
    mask.filter(ImageFilter.MedianFilter(3))
    s = ImageChops.add(mask, s) # final composite
    return s

def test_stitch():
    pids = [
            #'http://ifcb-data.whoi.edu/IFCB1_2011_290_060847_00008',
            #'http://ifcb-data.whoi.edu/IFCB1_2011_290_060847_00009'
            #'http://ifcb-data.whoi.edu/IFCB1_2011_292_022614_02752.html',
            #'http://ifcb-data.whoi.edu/IFCB1_2011_292_022614_02753.html'
            #'http://ifcb-data.whoi.edu/IFCB1_2011_293_025945_01223',
            #'http://ifcb-data.whoi.edu/IFCB1_2011_293_025945_01224'
            'http://ifcb-data.whoi.edu/IFCB1_2011_292_211737_00524',
            'http://ifcb-data.whoi.edu/IFCB1_2011_292_211737_00525'
    ]
    s = stitch(pids)
    pathname = 'stitch.png'
    s.save(pathname,'png')

def test_bin(pid):
    for pid1,pid2 in find_pairs(pid):
        try:
            s = stitch([pid1, pid2])
            pathname = 'stitch/' + ifcb.lid(pid1) + '.png'
            s.save(pathname,'png')
        except:
            print 'Error stitching ' + pid1 + ' and ' + pid2
        
if __name__=='__main__':
    test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_294_114650')