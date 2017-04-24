import numpy as np
from skimage import img_as_float
from skimage.exposure import rescale_intensity, histogram
from scipy.stats import moment
    
def masked_pixels(image,mask):
    return image[np.where(mask)]

def prctile(arr, ps):
    """implementation of MATLAB's prctile algorithm"""
    """note that this algorithm is available in more recent versions
    of numpy.percentile"""
    ap = np.asarray(arr).flatten().copy()
    ap.sort()
    n = ap.size
    pcts = 100 * (np.linspace(0.5,n-0.5,n) / n)
    ps = np.asarray(ps)
    if ps.ndim==0:
        ps = ps.reshape(-1)
    out = np.zeros((ps.size))
    for p,ix in zip(ps,range(ps.size)):
        if p < pcts[0]:
            out[ix] = ap[0]
        elif p > pcts[-1]:
            out[ix] = ap[-1]
        else:
            d = pcts - p
            above = np.argmin(d < 0)
            below = above - 1
            ap_below = ap[below]
            ap_above = ap[above]
            weights = 1. - np.abs(d / (100./n))
            weights *= weights > 0
            out[ix] = np.sum(weights * ap)
    return out

def texture_pixels(image,mask):
    p1, p99 = prctile(image,(1,99))
    fE = rescale_intensity(img_as_float(image), in_range=(p1/255.,p99/255.))
    E = np.round(fE * 255.)
    P = masked_pixels(E,mask)
    return P
    
def statxture(pixels):
    """computes a variety of texture stats from
    the image histogram.
    See Digital Image Processing Using MATLAB, ch. 11"""
    average_gray_level = np.mean(pixels)
    average_contrast = np.std(pixels)

    # compute normalized histogram
    H = histogram(pixels)[0]
    H = H / (1. * len(pixels))
    L = len(H)

    d = (L - 1.)**2

    normvar = np.var(pixels) / d
    smoothness = 1. - 1. / (1. + normvar)

    third_moment = moment(pixels,3) / d

    uniformity = np.sum(H**2)

    eps = np.finfo(float).eps
    entropy = 0. - np.sum(H * np.log2(H + eps)) 
    
    return average_gray_level, average_contrast, smoothness, \
        third_moment, uniformity, entropy
