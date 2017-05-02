import numpy as np

from functools import lru_cache

from numpy.fft import fft2, fftshift

from scipy.ndimage.interpolation import zoom

from skimage.draw import circle, polygon

# original MATLAB implementation: Kaccie Li, 2005
# Python port: Joe Futrelle, 2016

_DIM=301
_N_RINGS=50
_N_WEDGES=48

_eps = np.finfo(float).eps

@lru_cache()
def unit_circle(dim=_DIM):
    I = np.linspace(-1,1,dim)
    X, Y = np.meshgrid(I,I)
    r = np.sqrt(X**2 + Y**2)
    theta = np.arctan2(Y,X)
    return r, theta

@lru_cache()
def ring_mask(i,dim=_DIM,n_rings=_N_RINGS):
    # ring masks are a series of adjacent concentric rings
    # around the center of the unit circle
    w = 1. / n_rings
    r, _ = unit_circle(dim)
    inner_rad = i*w
    outer_rad = (i+1)*w
    return (r > inner_rad) & (r < outer_rad)

@lru_cache()
def kaccie_ring(i,dim=301,n_rings=_N_RINGS):
    c = dim//2
    df = (1./dim)*(1/6.45)
    f = np.linspace(-0.5/6.45,0.5/6.45,dim+1)[:dim]
    X, Y = np.meshgrid(f,f)
    r = np.sqrt(X**2 + Y**2)
    inner_rad = (i / (n_rings-1.)) * (c-3) * df # 50 rings
    outer_rad = (i / (n_rings-1.)) * (c-3) * df + (3 * df) # 50 rings
    out = np.zeros((dim,dim),dtype=np.bool)
    out[(r > inner_rad) & (r < outer_rad)] = 1
    return out
    
@lru_cache()
def kaccie_wedge(i,dim=_DIM,n_wedges=_N_WEDGES):
    # wedge masks are adjacent, equal-sized "pie slices" of the
    # bottom half of the unit circle
    r, th = unit_circle(dim)
    wedge = (r<=1) & (th > i*np.pi/n_wedges) & (th <= (i+1)*np.pi/n_wedges)
    # correct vertical strip error on middle wedge
    if i==(n_wedges//2)-1:
        wedge = np.logical_xor(wedge, th==np.pi/2)
    return wedge

@lru_cache()
def filter_masks(dim=_DIM,radius=0.1):
    # the center mask is a circle a tenth the size of a unit circle;
    # the filter mask is its inverse
    r, _ = unit_circle(dim)
    center_mask = r < radius
    return center_mask, np.invert(center_mask)

@lru_cache()
def kaccie_filter_masks(dim=_DIM):
    df = (1./(dim-1)) / 6.45
    I = np.linspace(-0.5/6.45,0.5/6.45,dim)
    Y, X = np.meshgrid(I,I)
    R = np.sqrt(X**2 + Y**2)
    filt = R > 15*df
    return np.invert(filt), filt
    
def ring_wedge(image,dim=_DIM):
    # perform fft and scale its intensities to dim x dim
    amp_trans = fftshift(fft2(image))
    int_trans = np.real(amp_trans * np.conj(amp_trans))
    z = (1.*dim/image.shape[0], 1.*dim/image.shape[1])
    int_trans = zoom(int_trans,z,order=1,mode='nearest') # linear
    # now compute stats of filtered intensities
    mask, filt = kaccie_filter_masks(dim)
    filter_img = mask * int_trans
    # intensities inside central area
    inner_int = np.sum(filter_img)
    # total intensity
    total_int = np.sum(int_trans)
    # ratio between central intensity and total intensity
    pwr_ratio = inner_int / total_int
    # now mask the intensities for wedge and ring calculations
    wedge_int_trans = int_trans * filt # wedges exclude center
    # only use the bottom half
    half = np.vstack((np.zeros(((dim//2)+1,dim)), np.ones((dim//2,dim)))).astype(np.bool)
    wedge_half = wedge_int_trans * half
    ring_half = int_trans * half
    # now compute unscaled wedge and ring vectors for all wedges and rings
    # these represent the total power found in each ring / wedge
    wedge_vector = np.array([np.sum(kaccie_wedge(i) * wedge_half) for i in range(48)])
    ring_vector = np.array([np.sum(kaccie_ring(i) * ring_half) for i in range(50)])
    # compute power integral over wedge vectors and scale vectors by it
    pwr_integral = np.sum(wedge_vector)
    wedges = wedge_vector / pwr_integral
    rings = ring_vector / pwr_integral
    # return all features
    return pwr_integral, pwr_ratio, wedges, rings
    
