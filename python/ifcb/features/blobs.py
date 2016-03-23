import numpy as np

from scipy.ndimage import measurements

from skimage.transform import rotate
from skimage.util import pad
from skimage.morphology import binary_closing, binary_dilation

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

def rotate_blob(blob, theta, niter=3):
    """rotate a blob and smooth out rotation artifacts"""
    # pad image so morphological operations won't produce edge artifacts
    blob = pad(blob,5,mode='constant')
    blob = rotate(blob,-1*theta,resize=True)
    blob = binary_closing(blob,SE3)
    blob = binary_dilation(blob,SE2)
    # note that H Sosik's version does one iteration
    # of thinning but 3 is closer to area-preserving
    blob = bwmorph_thin(blob,niter)
    return blob
    
def rotate_blob_sor_v2(blob, theta):
    """rotation with no morphological operations,
    which simulates rotation used for v2 SOR biovolume"""
    return rotate(blob,-1*theta,resize=True,order=0)

