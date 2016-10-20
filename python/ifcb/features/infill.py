"""
Provides infilling support for stitched IFCB rev 1 images
Based on pyifcb API
"""
import numpy as np
from scipy.interpolate import Rbf

from functools32 import lru_cache

from ifcb.data.utils import BaseDictlike
from ifcb.data.stitching import Stitcher

_LEGACY_EPS = 0.000001

def normz(a):
    m = np.max(a) + _LEGACY_EPS
    return a / m

def avg(l):
    return sum(l) / len(l)

def mv(eh):
    eps = _LEGACY_EPS # no dividing by zero
    colors = np.arange(256)
    n = np.sum(eh) + eps
    s = np.sum(eh * colors)
    mean = s / n
    variance = np.sum((colors - mean) ** 2 * eh) / n
    return (mean, variance)

# FIXME this is still too sensitive to lower modes
def bright_mv(image,mask=None):
    b = np.arange(257)
    if mask is not None:
        eh, _ = np.histogram(image[mask].ravel(),bins=b)
    else:
        eh, _ = np.histogram(image.ravel(),bins=b)
    return bright_mv_hist(eh)

_BMH_KERNEL = np.array([2,2,2,2,2,4,8,2,1,1,1,1,1])

def bright_mv_hist(histogram,exclude=[0,255]):
    histogram = np.array(histogram)
    histogram[np.array(exclude)] = 0
    # smooth the filter, preferring peaks with sharp declines on the higher luminance end
    peak = np.convolve(histogram,_BMH_KERNEL,'same')
    # now smooth that to eliminate noise
    peak = np.convolve(peak,np.ones(9),'same')
    # scale original signal to the normalized smoothed signal;
    # that will tend to deattenuate secondary peaks, and reduce variance of bimodal distros
    scaled = normz(peak)**20 * histogram
    # now compute mean and variance
    return mv(scaled)

def extract_background(image,estimated_background):
    bg_mask = image - estimated_background
    # now compute threshold from histogram
    h, _ = np.histogram(bg_mask, bins=np.arange(257))
    # reject dark part with threshold
    total = np.sum(h)
    running = np.cumsum(h)
    threshold = np.argmax(running > total * 0.95)
    table = np.zeros(256,dtype=np.uint8)
    table[threshold:] = 255
    bg_mask = np.take(table, bg_mask)
    m = np.logical_not(bg_mask)
    bg_mask[m] = image[m]
    return bg_mask

def edges_mask(b, target_number, raw_stitch):
    r1, r2 = target_number, target_number + 1
    ns = b.schema
    x = min(b[r1][ns.ROI_X], b[r2][ns.ROI_X])
    y = min(b[r1][ns.ROI_Y], b[r2][ns.ROI_Y])

    inset_factor = 25
    insets = []

    for r in [r1, r2]:
        insets += [b[r][ns.ROI_WIDTH] / inset_factor, b[r][ns.ROI_HEIGHT] / inset_factor]
    inset = np.sum(insets) / len(insets) # integer division

    edges = raw_stitch.mask == False
    
    for r in [r1, r2]:
        rx = b[r][ns.ROI_X] - x
        ry = b[r][ns.ROI_Y] - y
        edges[ry + inset : ry + b[r][ns.ROI_HEIGHT] - inset - 1,
              rx + inset : rx + b[r][ns.ROI_WIDTH] - inset - 1,] = False

    return edges

def infill(b, target_number, raw_stitch):
    # step 1: compute masks
    s = raw_stitch.filled(fill_value=0)
    rois_mask = raw_stitch.mask == False
    gaps_mask = raw_stitch.mask # where the missing data is
    edges = edges_mask(b, target_number, raw_stitch)
    # step 2: estimate background from edges
    # compute the mean and variance of the edges
    mean, variance = bright_mv(s,edges)
    # now use that as an estimated background
    s[gaps_mask] = mean
    # step 3: compute "probable background": low luminance delta from estimated bg
    w, h = s.shape
    flat_bg = np.full((w,h),mean,dtype=np.uint8)
    bg = extract_background(s,flat_bg)
    # also mask out the gaps, which are not "probable background"
    bg[gaps_mask] = 255
    # step 3a: improve mean/variance estimate
    mean, variance = bright_mv(bg)
    std_dev = np.sqrt(variance)
    # step 4: sample probable background to compute RBF for illumination gradient
    # grid
    div = 6 
    means, nodes = [], []
    rad = avg([h,w]) / div
    rad_step = int(rad/2)+1
    for x in range(0,h+rad,rad):
        for y in range(0,w+rad,rad):
            for r in range(rad,max(h,w),int(rad/3)+1):
                x1,y1,x2,y2 = (max(0,x-r),max(0,y-r),min(h-1,x+r),min(w-1,y+r))
                region = bg[y1:y2,x1:x2]
                nabe, _ = np.histogram(region, bins=np.arange(257))
                (m,v) = bright_mv_hist(nabe)
                if m > 0 and m < 255: # reject outliers
                    nodes.append((x,y))
                    means.append(m)
                    break
    # now construct radial basis functions for mean, based on the samples
    mean_rbf = Rbf([x for x,y in nodes], [y for x,y in nodes], means, epsilon=rad)
    # step 5: fill gaps with mean based on RBF and variance from bright_mv(edges)
    np.random.seed(0)
    noise = np.full((w,h),mean)
    mx, my = np.where(gaps_mask)
    noise[mx, my] = mean_rbf(my, mx)
    std_dev *= 0.66 # err on the side of smoother rather than noisier
    gaussian = np.random.normal(0, std_dev, size=mx.shape[0])
    noise[mx, my] += gaussian
    # step 6: final composite
    s[gaps_mask] = noise[gaps_mask]
    return s, rois_mask

class InfilledImages(BaseDictlike):
    """
    Wraps ``Bin`` to perform infilling of stitched images.

    Provides dict-like interface; keys are target numbers,
    each value is a pair of the infilled image and a mask
    indicating which pixels contain real (non-infill) data.

    Images that do not need to be infilled are also returned,
    but with None as the second (mask) pair of the tuple
    """
    def __init__(self, the_bin):
        """
        :param the_bin: the bin to delegate to
        :type the_bin: Bin
        """
        self.bin = the_bin
        self.stitcher = Stitcher(the_bin)
    @lru_cache()
    def excluded_targets(self):
        """
        Returns the target numbers of the targets that should
        be ignored in the original raw bin, because those targets
        are the second of a pair of stitched ROIs.

        This is just each included key + 1.
        """
        return map(lambda x: x + 1, self.stitcher.keys())
    def iterkeys(self):
        for k in self.bin:
            if k not in self.excluded_targets():
                yield k
    def has_key(self, target_number):
        in_bin = target_number in self.bin.images
        excluded = target_number in self.excluded_targets()
        return in_bin and not excluded
    @lru_cache(maxsize=2)
    def __getitem__(self, target_number):
        if target_number in self.stitcher:
            raw_stitch = self.stitcher[target_number]
            im, mask = infill(self.bin, target_number, raw_stitch)
            return (im, mask)
        else:
            im = self.bin.images[target_number]
            return (im, None)
