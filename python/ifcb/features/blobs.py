import numpy as np

from scipy.ndimage import measurements

from skimage.measure import regionprops
from skimage.transform import rotate
from skimage.util import pad
from skimage.morphology import binary_closing, binary_dilation
from math import ceil, floor

from ifcb.features.morphology import SE2, SE3, EIGHT, bwmorph_thin

def label_blobs(B):
    B = np.array(B).astype(np.bool)
    labeled, _ = measurements.label(B,structure=EIGHT)
    objects = measurements.find_objects(labeled)
    return labeled, objects
    
def find_blobs(B):
    """find and return all blobs in the image, using
    eight-connectivity. returns a labeled image, the
    bounding boxes of the blobs, and the blob masks cropped
    to those bounding boxes"""
    B = np.array(B).astype(np.bool)
    labeled, objects = label_blobs(B)
    blobs = [labeled[obj]==ix+1 for ix, obj in zip(range(len(objects)), objects)]
    return labeled, objects, blobs

def center_blob(B):
    """returns a new image centered on the blob's
    centroid"""
    # compute centroid
    yc, xc = np.mean(np.vstack(np.where(B)),axis=1)
    # center
    h, w = B.shape
    s = max(yc,h-yc,xc,w-xc)
    m = ceil(s*2)
    C = np.zeros((m,m),dtype=np.bool)
    y0, x0 = floor(s-yc), floor(s-xc)
    C[y0:y0+h,x0:x0+w]=B
    return C

def rotate_blob(blob, theta):
    """rotate a blob counterclockwise"""
    blob = center_blob(blob)
    # note that v2 uses bilinear interpolation in MATLAB
    # and that is not available in skimage rotate
    # so v3 uses nearest-neighbor
    blob = rotate(blob,-1*theta,order=0).astype(np.bool)
    # note that v2 does morphological post-processing and v3 does not
    return blob
    
def rotate_blob_sor_v2(blob, theta):
    """rotation with no morphological operations,
    which simulates rotation used for v2 SOR biovolume"""
    return rotate(blob,-1*theta,resize=True,order=0)

