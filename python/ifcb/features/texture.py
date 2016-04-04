import numpy as np
from skimage.exposure import rescale_intensity, histogram
from scipy.stats import moment
    
def masked_pixels(image,mask):
    return image[np.where(mask)]
    
def texture_pixels(image,mask):
    I = image.astype(np.float)
    p1, p99 = np.percentile(image,(1,99))
    E = rescale_intensity(I,in_range=(p1,p99)) * 255
    return masked_pixels(E,mask)
    
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
