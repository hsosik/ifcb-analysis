import numpy as np

from scipy.ndimage import measurements

from skimage.measure import regionprops
from skimage.transform import rotate
from skimage.util import pad
from skimage.morphology import binary_closing, binary_dilation

from .morphology import SE2, SE3, EIGHT, bwmorph_thin

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
    m = int(np.ceil(s*2))
    C = np.zeros((m,m),dtype=np.bool)
    y0, x0 = int(np.floor(s-yc)), int(np.floor(s-xc))
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
    
def blob_shape(b0):
    h, w = b0.shape
    blr = np.fliplr(b0)
    bud = np.flipud(b0)

    # reproduce MATLAB's center-of-pixel approach
    x0 = np.argmax(np.sum(b0,axis=0)>0) + 0.5
    x1 = w - np.argmax(np.sum(blr,axis=0)>0)
    y0 = np.argmax(np.sum(b0,axis=1)>0) + 0.5
    y1 = h - np.argmax(np.sum(bud,axis=1)>0)
    h = int((y1-y0) + 0.5)
    w = int((x1-x0) + 0.5)
    
    return h,w

