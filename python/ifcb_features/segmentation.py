import numpy as np

from skimage import img_as_float
from scipy.ndimage.morphology import binary_fill_holes
from skimage.morphology import binary_closing, binary_dilation, remove_small_objects

try:
    import skimage.filters as imfilters
except ImportError:
    import skimage.filter as imfilters

from .phasecong import phasecong_Mm
from .morphology import SE2, SE3, hysthresh, bwmorph_thin

# parameters
HT_T1, HT_T2 = 0.2, 0.1
BLOB_MIN = 150
DARK_THRESHOLD_ADJUSTMENT=0.65

def dark_threshold(roi,adj=DARK_THRESHOLD_ADJUSTMENT):
    thresh = int(round(imfilters.threshold_otsu(roi) * adj))
    return roi < thresh

def segment_roi(roi):
    # step 1. phase congruency (edge detection)
    Mm = phasecong_Mm(roi)
    # step 2. hysteresis thresholding (of edges)
    B = hysthresh(Mm,HT_T1,HT_T2)
    # step 3. trim pixels off border
    B[B[:,1]==0,0]=0
    B[B[:,-2]==0,-1]=0
    B[0,B[1,:]==0]=0
    B[-1,B[-2,:]==0]=0
    # step 4. threshold to find dark areas
    dark = dark_threshold(roi, DARK_THRESHOLD_ADJUSTMENT)
    # step 5. add dark areas back to blob
    B = np.logical_or(B,dark)
    # step 6. binary closing
    B = binary_closing(B,SE3)
    # step 7. binary dilation
    B = binary_dilation(B,SE2)
    # step 8. thinning
    B = bwmorph_thin(B,3)
    # step 9. fill holes
    B = binary_fill_holes(B)
    # step 10. remove blobs <= BLOB_MIN
    B = remove_small_objects(B,BLOB_MIN+1,connectivity=2)
    # done.
    return B
    
