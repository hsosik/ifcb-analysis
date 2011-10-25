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
    # smooth the filter, preferring peaks with sharp declines on the higher luminance end
    peak = convolve(eh,[2,2,2,2,2,2,4,1,1,1,1,1,1],'same')
    # now smooth that to eliminate noise
    peak = convolve(peak,[1,1,1,1,1,1,1,1,1],'same') 
    # scale original signal to the normalized smoothed signal;
    # that will tend to deattenuate secondary peaks, and reduce variance of bimodal distros
    scaled = [(x**5)*y for x,y in zip(normz(peak),eh)] # FIXME magic number
    # now compute mean and variance of the scaled signal
    return mv(scaled)

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
        # draw a white rectangle around the edges of the roi
        edges.paste(255, (ry, rx, ry + roi.height, rx + roi.width))
        # fill it with black (leaving just edge pixels)
        draw.rectangle((ry + 1, rx + 1, ry + roi.height - 2, rx + roi.width - 2), fill=0)
    # erase the edge mask where it touches the outer border of the entire stitched field
    draw.rectangle((0,0,h-1,w-1), outline=0)
    # OK. Now the stitched image contains both ROIs and black gap
    # The mask contains just the gap, in white
    # The edges is a mask just for the pixels bordering on the edge of the gap
    # compute the mean and variance of the edges
    (mean,variance) = bright_mv(s,edges)
    # now compute the mean and variance of the left, right, top and bottom edges.
    # these edges have black gaps where they intersect with missing regions; "bright_mv"
    # drops those from the histogram. further, a target may be cropped at the edge,
    # contributing dark pixels. this algorithm scales the histogram to de-attenuate secondary peaks
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
    # now construct a radial basis function for the background illumination
    # first determine where the edge means are centered, physically
    mask_pix = mask.load()
    bottom_center = avg([i for i in range(h) if mask_pix[i,0] != 255])
    top_center = avg([i for i in range(h) if mask_pix[i,w-1] != 255])
    left_center = avg([i for i in range(w) if mask_pix[0,i] != 255])
    right_center = avg([i for i in range(w) if mask_pix[h-1,i] != 255])
    #(bottom_center,top_center,left_center,right_center) = (h/2,h/2,w/2,w/2)
    nodes = [(bottom_center,0),(top_center,w-1),(0,left_center),(h-1,right_center)]
    means = [bottom_mean, top_mean, left_mean, right_mean]
    eps = avg([h,w])
    mean_rbf = interpolate.Rbf([x for x,y in nodes], [y for x,y in nodes], means, function='gaussian', epsilon=eps*2.5)
    # variance is average of lowest two variances
    (v1,v2,v3,v4) = sorted([left_variance, right_variance, top_variance, bottom_variance])
    variance = (v1 * 0.30) + (v2 * 0.30) + (v3 * 0.20) + (v4 * 0.20) # shortest (lowest-variance) edges count most
    # now construct the noise from the stats
    # first grow the mask past the edges, to keep the median filter later from generating an edge artifact
    grow_mask = mask.copy().filter(ImageFilter.MaxFilter(5))
    grow_mask_pix = grow_mask.load()
    noise = Image.new('L',(h,w),mean)
    noise_pix = noise.load()
    background = Image.new('L',(h,w),0)
    background_pix = background.load()
    gaussian = numpy.random.normal(0, 1.0, size=(h,w)) # it's normal
    std_dev = sqrt(variance)
    for x in xrange(h):
        for y in xrange(w):
            background_luminance = mean_rbf(x,y) # estimated background is computed by the RBF
            background_pix[x,y] = background_luminance
            if grow_mask_pix[x,y] == 255: # only for pixels in the mask
                # fill is estimated background + noise
                noise_pix[x,y] = background_luminance + (gaussian[x,y] * std_dev)
    # apply a median filter to the noise
    noise = noise.filter(ImageFilter.MedianFilter(3))
    # add the noise, but mask it
    s.paste(noise,None,mask)
    # return the image and the estimated background
    return (s,background)

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

