from urllib2 import urlopen, Request
import json
from StringIO import StringIO
from PIL import Image, ImageDraw, ImageChops, ImageFilter
from collections import namedtuple
import math
from math import sqrt
import numpy
from numpy import convolve, median
import ifcb
import os
import sys
from matplotlib import pyplot
import random
from scipy import interpolate

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

def normz(a):
    m = max(a) + 0.000001
    return [float(x) / float(m) for x in a]

def mv(eh):
    n = 0.000001
    sum = 0
    counts = zip(range(256), eh)
    for color,count in counts:
        n += count
        sum += count * color
    mean = sum / n
    sum2 = 0
    for color,count in counts:
        sum2 += ((color - mean) ** 2) * count
    variance = sum2 / n
    return (mean, variance)
    
def bright_mv(image,mask):
    eh = image.histogram(mask)
    # toast zeroes
    eh[0] = 0
    # smooth the filter, preferring peaks with sharp declines on the higher luminance end
    peak = convolve(eh,[2,2,2,2,2,2,4,1,1,1,1,1,1],'same')
    # now smooth that to eliminate noise
    peak = convolve(peak,[1,1,1,1,1,1,1,1,1],'same') 
    # scale original signal to the normalized smoothed signal ^3;
    # that will tend to deattenuate secondary peaks, and reduce variance of bimodal distros
    scaled = [(x**3)*y for x,y in zip(normz(peak),eh)] # FIXME magic number ^3
    # now compute mean and variance of the scaled signal
    return mv(scaled)

            #pyplot.hold(False)
            #pyplot.plot(eh)
            #pyplot.hold(True)
            #peak = convolve(eh,[2,2,2,2,2,2,4,1,1,1,1,1,1],'same')
            #peak = convolve(peak,[1,1,1,1,1,1,1,1,1],'same')
            #peak = [x/40 for x in peak]
            #pyplot.annotate('peak',(peak_x,max_y), (peak_x-50,max_y), arrowprops=dict(arrowstyle="->",connectionstyle="arc,angleA=0,armA=30,rad=10"))
            #pyplot.annotate('upper',(max_x,peak[max_x]), (max_x+50,peak[max_x]+20), arrowprops=dict(arrowstyle="->",connectionstyle="arc,angleA=0,armA=30,rad=10"))
            #pyplot.annotate('lower',(min_x,peak[min_x]), (min_x-50,peak[min_x]+20), arrowprops=dict(arrowstyle="->",connectionstyle="arc,angleA=0,armA=30,rad=10"))
            #scaled = [(x**3)*y*10 for x,y in zip(normz(peak),eh)]
            #pyplot.plot([x * max(eh) * 10 for x in normz(peak)])
            #pyplot.plot(scaled)
            #pyplot.savefig(basename+'_edgehist.png')

def stitch(pids):
    rois = {}
    for pid in pids:
        p = get_image_properties(pid)
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
    (mean,variance) = bright_mv(s,edges)
    borders = Image.new('L',(h,w),0)
    draw = ImageDraw.Draw(borders)
    draw.rectangle((0,0,1,w),fill=255) # left edge
    (left_mean, left_variance) = bright_mv(s,borders)
    draw.rectangle((0,0,h,w),fill=0) # erase
    draw.rectangle((h-1,0,h,w),fill=255) # right edge
    (right_mean, right_variance) = bright_mv(s,borders)
    draw.rectangle((0,0,h,w),fill=0) # erase
    draw.rectangle((0,w,h,w-1),fill=255) # top edge
    (top_mean, top_variance) = bright_mv(s,borders)
    draw.rectangle((0,0,h,w),fill=0) # erase
    draw.rectangle((0,0,h,1),fill=255) # bottom edge
    (bottom_mean, bottom_variance) = bright_mv(s,borders)
    # now construct a radial basis function for the mean.
    # here we assume the mean and variance samples are centered on their edge (not a correct assumption!)
    nodes = [(h/2,0),(h/2,w-1),(0,w/2),(h-1,w/2),(h/2,w/2)]
    # further we estimate the mean at the center of each edge by including neighboring edge means
    # also estimate the mean at the center of the image from the edge means
    # this is no substitute for collecting more samples from the edge data
    means = [bottom_mean, top_mean, left_mean, right_mean, (bottom_mean + top_mean + left_mean + right_mean) / 4]
    mean_rbf = interpolate.Rbf([x for x,y in nodes], [y for x,y in nodes], means)
    # variance is average of lowest two variances
    (v1,v2) = sorted([left_variance, right_variance, top_variance, bottom_variance])[:2]
    variance = (v1 + v2) / 2; # average of bottom two (likely short-side) variances
    # now construct the noise from the stats
    grow_mask = mask.copy().filter(ImageFilter.MaxFilter(5)) # grow the mask past the edge
    noise = Image.new('L',(h,w),mean)
    mask_pix = grow_mask.load()
    noise_pix = noise.load()
    gaussian = numpy.random.normal(0, 1.0, size=(h,w)) # it's normal
    for x in xrange(h):
        for y in xrange(w):
            if mask_pix[x,y] == 255: # only for pixels in the mask
                # mean is based on the gradient estimate function
                mean = mean_rbf(x,y)
                # then add some gaussian noise
                noise_pix[x,y] = mean + (gaussian[x,y] * sqrt(variance))
    # apply a median filter to the noise
    noise = noise.filter(ImageFilter.MedianFilter(3))
    s.paste(noise,None,mask)
    return (s,s.histogram(edges))

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
    catch = False
    dir = os.path.join('stitch',ifcb.lid(pid))
    try:
        os.mkdir(dir)
    except:
        pass
    os.chdir(dir)
    for pid1,pid2 in find_pairs(pid):
        try:
            (s,eh) = stitch([pid1, pid2])
            print 'Stitched %s and %s' % (pid1, pid2)
            basename = ifcb.lid(pid1)
            s.save(basename+'.png','png')
        except:
            if catch:
                print 'Error stitching: "%s" for %s and %s' % (sys.exc_info()[0], pid1, pid2)
            else:
                raise
        
if __name__=='__main__':
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_294_114650')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_282_235113')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_121939')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_287_152253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_295_022253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_121647')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_135001')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_242_133222')
    test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_150210')