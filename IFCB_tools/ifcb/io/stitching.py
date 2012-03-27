from PIL import Image, ImageDraw, ImageChops, ImageFilter
import math
from math import sqrt
import numpy as np
from numpy import convolve, median
import os
import sys
import random
from scipy import interpolate
import time
from random import random
from ifcb.io import Timestamped, TARGET_INFO
from ifcb.io.cache import cache_obj
import ifcb

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
            yield (prev.targetNumber, target.targetNumber)
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
def bright_mv(image,mask=None):
    eh = image.histogram(mask)
    # toast extrema
    return bright_mv_hist(eh)

def bright_mv_hist(histogram,exclude=[0,255]):
    for x in exclude:
        histogram[x] = 0 
    # smooth the filter, preferring peaks with sharp declines on the higher luminance end
    peak = convolve(histogram,[2,2,2,2,2,4,8,2,1,1,1,1,1],'same')
    # now smooth that to eliminate noise
    peak = convolve(peak,[1,1,1,1,1,1,1,1,1],'same')
    # scale original signal to the normalized smoothed signal;
    # that will tend to deattenuate secondary peaks, and reduce variance of bimodal distros
    scaled = [(x**20)*y for x,y in zip(normz(peak),histogram)] # FIXME magic number
    # now compute mean and variance of the scaled signal
    return mv(scaled)
    
def extract_background(image,estimated_background):
    bg_mask = ImageChops.difference(image,estimated_background)
    # now compute threshold from histogram
    h = bg_mask.histogram()
    # reject dark part with threshold
    total = sum(h)
    running = 0
    for t in range(256):
        running += h[t]
        if running > total * 0.95:
            threshold = t
            break
    #print threshold
    table = range(256)
    for t in range(256):
        if t < threshold:
            table[t] = 0
        else:
            table[t] = 255;
    bg_mask = bg_mask.point(table)
    bg_mask = ImageChops.screen(image,bg_mask)
    return bg_mask

def stitched_box(targets):
    # compute bounds relative to the camera field
    x = min([target.left for target in targets])
    y = min([target.bottom for target in targets])
    w = max([target.left + target.width for target in targets]) - x
    h = max([target.bottom + target.height for target in targets]) - y
    return (x,y,w,h)
    
def mask(targets):
    (x,y,w,h) = stitched_box(targets)
    # now we swap width and height to rotate the image 90 degrees
    mask = Image.new('L',(h,w), 0) # a mask of the non-missing region
    for roi in targets:
        rx = roi.left - x
        ry = roi.bottom - y
        mask.paste(255, (ry, rx, ry + roi.height, rx + roi.width))
    return mask

# stitch with no noise fill
def stitch_raw(targets,images=None,box=None):
    # fetch images
    if images is None:
        images = [target.image() for target in targets]
    # compute bounds relative to the camera field
    if box is None:
        box = stitched_box(targets)
    (x,y,w,h) = box
    # now we swap width and height to rotate the image 90 degrees
    s = Image.new('L',(h,w)) # the stitched image with a missing region
    for (roi,image) in zip(targets,images):
        rx = roi.left - x
        ry = roi.bottom - y
        rw = roi.width 
        rh = roi.height
        roi_box = (ry, rx, ry + rh, rx + rw)
        s.paste(image, roi_box) # paste in the right location
    return s

def edges_mask(targets,images=None):
    # fetch images
    if images is None:
        images = [target.image() for target in targets]
    # compute bounds relative to the camera field
    (x,y,w,h) = stitched_box(targets)
    # now we swap width and height to rotate the image 90 degrees
    edges = Image.new('L',(h,w), 0) # just the edges of the missing region
    draw = ImageDraw.Draw(edges)
    for (roi,image) in zip(targets,images):
        rx = roi.left - x
        ry = roi.bottom - y
        edges.paste(255, (ry, rx, ry + roi.height, rx + roi.width))
    # blank out a rectangle in the middle of the rois
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
    return edges

def euclidian(x1,y1,x2,y2):
    return sqrt(((x1 - x2) ** 2) + ((y1 - y2) ** 2))

def concentric(l):
    n = len(l)
    even = [l[i] for i in range(n) if i % 2 == 0]
    odd = [l[i] for i in range(n) if i % 2 != 0]
    for (one,two) in zip(even,reversed(odd)):
        yield one
        yield two

def hist(samples):
    h = [0 for ignore in range(256)]
    for s in samples:
        h[s] += 1
    return h

def stitch(targets,images=None,roi_file=None):
    # fetch images
    if images is None:
        images = [target.image(roi_file) for target in targets]
    start = time.time()
    timings = {}
    then = time.time()
    # compute bounds relative to the camera field
    (x,y,w,h) = stitched_box(targets)
    timings['stitch_box'] = time.time() - then
    then = time.time()
    # note that w and h are switched from here on out to rotate 90 degrees.
    # step 1: compute masks
    s = stitch_raw(targets,images,(x,y,w,h)) # stitched ROI's with black gaps
    timings['stitch_raw'] = time.time() - then
    then = time.time()
    rois_mask = mask(targets) # a mask of where the ROI's are
    gaps_mask = ImageChops.invert(rois_mask) # its inverse is where the gaps are
    edges = edges_mask(targets,images) # edges are pixels along the ROI edges
    timings['mask'] = time.time() - then
    then = time.time()
    # step 2: estimate background from edges
    # compute the mean and variance of the edges
    (mean,variance) = bright_mv(s,edges)
    # now use that as an estimated background
    flat_bg = Image.new('L',(h,w),mean) # FIXME
    s.paste(mean,None,gaps_mask)
    timings['estimate_bg'] = time.time() - then
    then = time.time()
    # step 3: compute "probable background": low luminance delta from estimated bg
    bg = extract_background(s,flat_bg)
    # also mask out the gaps, which are not "probable background"
    bg.paste(255,None,gaps_mask)
    timings['extract_bg'] = time.time() - then
    then = time.time()
    # step 3a: improve mean/variance estimate
    (mean,variance) = bright_mv(bg)
    std_dev = sqrt(variance)
    timings['bg_mv'] = time.time() - then
    then = time.time()
    # step 4: sample probable background to compute RBF for illumination gradient
    # grid
    div = 6
    means = []
    nodes = []
    rad = avg([h,w]) / div
    rad_step = int(rad/2)+1
    for x in range(0,h+rad,rad):
        for y in range(0,w+rad,rad):
            for r in range(rad,max(h,w),int(rad/3)+1):
                box = (max(0,x-r),max(0,y-r),min(h-1,x+r),min(w-1,y+r))
                region = bg.crop(box)
                nabe = region.histogram()
                (m,v) = bright_mv_hist(nabe)
                if m > 0 and m < 255: # reject outliers
                    nodes.append((x,y))
                    means.append(m)
                    break
    timings['sample'] = time.time() - then
    then = time.time()
    # now construct radial basis functions for mean, based on the samples
    mean_rbf = interpolate.Rbf([x for x,y in nodes], [y for x,y in nodes], means, epsilon=rad)
    timings['rbf'] = time.time() - then
    then = time.time()
    # step 5: fill gaps with mean based on RBF and variance from bright_mv(edges)
    mask_pix = gaps_mask.load()
    noise = Image.new('L',(h,w),mean)
    noise_pix = noise.load()
    np.random.seed(0)
    gaussian = np.random.normal(0, 1.0, size=(h,w)) # it's normal
    std_dev *= 0.66 # err on the side of smoother rather than noisier
    timings['random'] = time.time() - then
    then = time.time()
    mask_x = []
    mask_y = []
    for x in xrange(h):
        for y in xrange(w):
            if mask_pix[x,y] == 255: # only for pixels in the mask
                mask_x.append(x)
                mask_y.append(y)
    rbf_fill = mean_rbf(np.array(mask_x), np.array(mask_y))
    timings['rbf_fill'] = time.time() - then
    then = time.time()
    for x,y,r in zip(mask_x, mask_y, rbf_fill):
        # fill is illumination gradient + noise
        noise_pix[x,y] = r + (gaussian[x,y] * std_dev)
    # step 6: final composite
    s.paste(noise,None,gaps_mask)
    timings['noise_fill'] = time.time() - then
    elapsed = time.time() - start
    #norm = sum(timings.values())
    #for k in timings:
    #    seconds = int(timings[k] * 1000)
    #    percent = int(timings[k] * 1000 / norm) / 10.0
    #    timings[k] = '%dms (%%%.1f)' % (seconds,percent)
    #elapsed = int(elapsed * 1000)
    #print (elapsed,timings)
    return (s,rois_mask)

# for bin I need iso8601time, rfc822time, headers(), properties(), and pid
# also targets

class StitchedTarget(object):
    """Represents a Target (e.g., an image and metadata from a single ROI)"""
    info = {}
    bin = None
    img = None 
    msk = None
    
    def __init__(self,bin,n1,n2):
        self.bin = bin
        (target1, target2) = list(bin.targets([n1,n2]))
        self.targets = [target1, target2]
        (left,bottom,width,height) = stitched_box(self.targets)
        info = target1.info.copy()
        info['left'] = left
        info['bottom'] = bottom
        info['width'] = width
        info['height'] = height
        info['stitched'] = 1
        self.info = info
    
    def __getattr__(self,name):
        if name in TARGET_INFO:
            return self.info[name]
        else:
            return object.__getattribute__(self.bin,name)
        
    def __repr__(self):
        return '{Target(stitched) '+self.pid + '}'
    
    @property
    def lid(self):
        return ifcb.lid(self.pid)
    
    def time(self):
        bin_time = calendar.timegm(self.bin.time()) # bin seconds since epoch
        return time.gmtime(bin_time + self.frameGrabTime)
    
    def iso8601time(self):
        return time.strftime(ISO_8601_FORMAT, self.time())
    
    def imagenmask(self,roi_file=None):
        if self.img is None:
            (self.img, self.msk) = stitch(self.targets,roi_file)
        return (self.img, self.msk)
    
    def image(self,roi_file=None):
        (image,mask) = self.imagenmask(roi_file)
        return image
    
    def mask(self):
        if self.msk is None:
            self.msk = mask(self.targets)
        return self.msk
    
    def stitch_raw(self):
        return stitch_raw(self.targets)
    
class StitchedBin(object):
    bin = None
    pairs = None
    stitches = None

    def __init__(self,bin):
        self.bin = bin
        self.pid = bin.pid

    def __getattr__(self,name):
        if name in TARGET_INFO:
            return self.info[name]
        try:
            return object.__getattribute__(self,name)
        except:
            return object.__getattribute__(self.bin,name)

    def headers(self):
        return self.bin.headers()
    
    def properties(self,include_pid=False):
        return self.bin.properties(include_pid)

    def __repr__(self):
        return '{Bin(stitched) '+self.pid + '}'

    def all_targets(self):
        return list(self)

    def __pairs(self):
        if self.pairs is None:
            cache_key = '_'.join([ifcb.lid(self.pid),'spairs'])
            self.pairs = cache_obj(cache_key,lambda: list(find_pairs(self.bin)))
        return self.pairs
    
    def iterate(self,skip=0):
        pairs = self.__pairs()
        head2tail = {}
        tail2head = {}
        for one,two in pairs:
            head2tail[one] = two
            tail2head[two] = one
        for target in self.bin.iterate(skip):
            # need stitching?
            stitched = False
            head = target.targetNumber
            if self.stitches is None:
                self.stitches = {}
            if head in self.stitches:
                yield self.stitches[head]
            elif head in head2tail:
                tail = head2tail[head]
                st = StitchedTarget(self.bin,head,tail)
                self.stitches[head] = st
                yield st
            elif head in tail2head:
                pass
            else:
                yield target
                
     # generate all targets
    def __iter__(self):
        return iter(self.iterate())

    def length(self):
        count = 0
        for target in self.iterate():
            count += 1
        return count

    def target(self,n):
        for target in self.iterate(n-1):
            if target.targetNumber == n:
                return target
            if target.targetNumber > n:
                raise KeyError

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

