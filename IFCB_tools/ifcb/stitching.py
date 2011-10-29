from PIL import Image, ImageDraw, ImageChops, ImageFilter
import math
from math import sqrt
import numpy
from numpy import convolve, median
import os
import sys
import random
from scipy import interpolate
from io.path import Filesystem

def overlaps(t1, t2):
    if t1.trigger == t2.trigger:
        (x11, y11) = (t1.left, t1.bottom)
        (x12, y12) = (x11 + t1.width, y11 + t1.height)
        (x21, y21) = (t2.left, t2.bottom)
        (x22, y22) = (x21 + t2.width, y21 + t2.height)
        return x11 < x22 and x12 > x21 and y11 < y22 and y12 > y21
    return False

def find_pairs(bin):
    prev = None
    for target in bin:
        if prev is not None and overlaps(target, prev):
            yield (prev, target)
        prev = target

def normz(a):
    m = max(a) + 0.000001 # dividing by zero is bad
    return [float(x) / float(m) for x in a]

def avg(l):
    return sum(l) / len(l)
    
def mv(eh):
    n = 0.000001 # no dividing by zero
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

# FIXME this is still too sensitive to lower modes
def bright_mv(image,mask):
    eh = image.histogram(mask)
    # toast zeroes
    eh[0] = 0
    return bright_mv_hist(eh)

def bright_mv_hist(histogram):
    # smooth the filter, preferring peaks with sharp declines on the higher luminance end
    peak = convolve(histogram,[2,2,2,2,2,2,4,1,1,1,1,1,1],'same')
    # now smooth that to eliminate noise
    peak = convolve(peak,[1,1,1,1,1,1,1,1,1],'same') 
    # scale original signal to the normalized smoothed signal;
    # that will tend to deattenuate secondary peaks, and reduce variance of bimodal distros
    scaled = [(x**13)*y for x,y in zip(normz(peak),histogram)] # FIXME magic number
    # now compute mean and variance of the scaled signal
    return mv(scaled)
    
def extract_background(image,estimated_background):
    bg_mask = ImageChops.difference(image,estimated_background)
    # now compute threshold from histogram
    h = bg_mask.histogram()
    # reject bottom part with threshold
    total = sum(h)
    running = 0
    for t in range(256):
        running += h[t]
        if running > total * 0.8:
            threshold = t
            break
    #print threshold
    table = range(256)
    for t in range(256):
        if t < threshold: # FIXME magic number
            table[t] = 0
        else:
            table[t] = 255;
    bg_mask = bg_mask.point(table)
    bg_mask = ImageChops.screen(image,bg_mask)
    return bg_mask

def stitch(targets):
    # compute bounds relative to the camera field
    x = min([target.left for target in targets])
    y = min([target.bottom for target in targets])
    w = max([target.left + target.width for target in targets]) - x
    h = max([target.bottom + target.height for target in targets]) - y
    # now we swap width and height to rotate the image 90 degrees
    s = Image.new('L',(h,w)) # the stitched image with a missing region
    mask = Image.new('L',(h,w), 255) # a mask of the missing region
    edges = Image.new('L',(h,w), 0) # just the edges of the missing region
    draw = ImageDraw.Draw(edges)
    for roi in targets:
        rx = roi.left - x
        ry = roi.bottom - y
        s.paste(roi.image(), (ry, rx)) # paste in the right location
        mask.paste(0, (ry, rx, ry + roi.height, rx + roi.width))
        edges.paste(255, (ry, rx, ry + roi.height, rx + roi.width))
    # blank out an ellipse in the middle of the ROI edge mas
    inset_factor = 25
    insets = []
    for roi in targets:
        rx = roi.left - x
        ry = roi.bottom - y
        insets += [roi.width / inset_factor, roi.height / inset_factor]
    inset = avg(insets)
    for roi in targets:
        rx = roi.left - x
        ry = roi.bottom - y
        draw.rectangle((ry + inset, rx + inset, ry + roi.height - inset - 1, rx + roi.width - inset - 1), fill=0)
    # OK. Now the stitched image contains both ROIs and black gap
    # The mask contains just the gap, in white
    # The edges is a mask just for the pixels bordering on the edge of the gap
    # compute the mean and variance of the edges
    (mean,variance) = bright_mv(s,edges)
    # now use that as an estimated background
    flat_bg = Image.new('L',(h,w),mean)
    s.paste(mean,None,mask)
    # now compute diff between image and estimated background,
    # and mask that out of the data 
    bg = extract_background(s,flat_bg)
    # also mask the gaps out of the data
    bg.paste(255,None,mask)
    # now sample that, ignoring masked pixels
    nodes = []
    means = []
    # grid
    div = 5
    # make sure we get some samples
    while len(nodes) == 0:
        div += 1
        rad = avg([h,w]) / div
        for x in range(rad,h,rad*2):
            for y in range(rad,w,rad*2):
                for r in range(rad,max(h,w),2):
                    box = (max(0,x-r),max(0,y-r),min(h-1,x+r),min(w-1,y+r))
                    region = bg.crop(box)
                    nabe = region.histogram()
                    nabe[255] = 0 # reject masked target
                    (m,v) = bright_mv_hist(nabe)
                    if m > 0 and m < 255: # reject outliers
                        nodes += [(x,y)]
                        means += [m]
                        break
    # now construct radial basis functions for mean, based on the samples
    eps = avg([h,w]) * 1.2
    # FIXME if no samples, will fail! need to use different sampling grid
    mean_rbf = interpolate.Rbf([x for x,y in nodes], [y for x,y in nodes], means, epsilon=eps)
    mask_pix = mask.load()
    noise = Image.new('L',(h,w),mean)
    noise_pix = noise.load()
    gaussian = numpy.random.normal(0, 1.0, size=(h,w)) # it's normal
    std_dev = sqrt(variance)
    for x in xrange(h):
        for y in xrange(w):
            if mask_pix[x,y] == 255: # only for pixels in the mask
                # fill is estimated background + noise
                noise_pix[x,y] = mean_rbf(x,y) + (gaussian[x,y] * std_dev)
    # now blur the edges of the noise by adding back pixels from the data
    noise.paste(s,None,ImageChops.invert(mask))
    noise = noise.filter(ImageFilter.MedianFilter(7))
    # now add a little more noise to compensate for the median smoothing
    noise_pix = noise.load()
    for x in xrange(h):
        for y in xrange(w):
            if mask_pix[x,y] == 255: # only for pixels in the mask
                noise_pix[x,y] += gaussian[x,y] * (std_dev / 3)
    s.paste(noise,None,mask)
    return (s,ImageChops.invert(mask),edges)

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

