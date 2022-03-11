import numpy as np

from skimage import img_as_float32
from scipy.ndimage.morphology import binary_fill_holes
from skimage.morphology import binary_closing, binary_dilation, binary_erosion, remove_small_objects, diamond
import skimage.filters as imfilters
from sklearn.cluster import KMeans

from phasecong import phasecong_Mm
from morphology import SE3, hysthresh, bwmorph_thin

SE2 = diamond(2, np.bool)
SED = diamond(1, np.bool)

# parameters
HT_T1, HT_T2 = 0.3, 0.09
BLOB_MIN = 40
DARK_THRESHOLD_ADJUSTMENT = 0.75


def kmeans_segment(roi):
    r = img_as_float32(roi)
    # compute "dark" and "light" clusters
    km = KMeans(n_clusters=2, n_init=1, init=np.array([[0], [1]]), max_iter=100)
    km.fit(r.reshape(-1, 1))
    J = km.labels_
    C = km.cluster_centers_
    bg_label = np.argmax(C)
    # find the darkest pixel value in the bright (background) cluster
    roi_1d = r.ravel()
    darkest_background = np.min(roi_1d[J == bg_label])
    # use it to compute a threshold
    threshold = darkest_background * DARK_THRESHOLD_ADJUSTMENT
    # extend the background using that threshold
    J[roi_1d > threshold] = bg_label
    # return True for non-background pixels
    return (J != bg_label).reshape(roi.shape)


def apply_blob_min(roi):
    return remove_small_objects(roi, BLOB_MIN + 1, connectivity=2)


def segment_roi(roi, raw_stitch=None):
    # step 1. phase congruency (edge detection)
    Mm = phasecong_Mm(roi)
    # step 1a: for stitched images, chop the raw stitch mask
    # after growing it one pixel
    if raw_stitch is not None:
        mask = binary_dilation(raw_stitch.mask)
        Mm[mask] = 0
    # step 2. hysteresis thresholding (of edges)
    B = hysthresh(Mm,HT_T1,HT_T2)
    # step 3. trim pixels off border
    B[B[:,1]==0,0]=0
    B[B[:,-2]==0,-1]=0
    B[0,B[1,:]==0]=0
    B[-1,B[-2,:]==0]=0
    # step 4. binary closing
    B = binary_closing(B, SE2)
    # step 5. morphological thinning
    B = bwmorph_thin(B, 3)
    # step 6. background/foreground thresholding
    dark = kmeans_segment(roi)
    B = np.logical_or(B, dark)
    # step 7. fill holes (surrounded by target pixels)
    B = binary_fill_holes(B)
    # step 8. erode and remove small blobs
    B_eroded = binary_erosion(B, SED)
    if np.sum(apply_blob_min(B_eroded)) > 0:
        B = B_eroded
    B = apply_blob_min(B)
    return B

