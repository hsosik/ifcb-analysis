import numpy as np

from scipy.spatial.distance import pdist, cdist
from scipy import stats

from skimage.measure import regionprops

from ifcb.features.morphology import find_perimeter

def hist_stats(arr):
    """returns mean, median, skewness, and kurtosis"""
    arr = np.array(arr).flatten()
    mean = np.mean(arr)
    median = np.median(arr)
    skewness = stats.skew(arr)
    kurtosis = stats.kurtosis(arr,fisher=False)
    return mean, median, skewness, kurtosis
    
def perimeter_stats(points, equiv_diameter):
    """compute stats of pairwise distances
    between all given points, given an
    equivalent diameter.
    returns mean, median, skewness, and kurtosis
    """
    B = np.vstack(points).T
    # in H Sosik's v2 the square form is used,
    # use the short form here
    D = pdist(B) / equiv_diameter
    return hist_stats(D)

def hausdorff(A,B):
    """compute the Hausdorff distance between two point sets"""
    D = cdist(A,B,'sqeuclidean')
    fhd = np.max(np.min(D,axis=0))
    rhd = np.max(np.min(D,axis=1))
    return np.sqrt(max(fhd,rhd))
    
def modified_hausdorff(A,B):
    """compute the 'modified' Hausdorff distance between two
    point sets as described in
    M. P. Dubuisson and A. K. Jain. A Modified Hausdorff distance
    for object matching. In ICPR94, pages A:566-568, Jerusalem, Israel,
    1994.
    http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=576361
    """
    D = cdist(A,B)
    fhd = np.mean(np.min(D,axis=0))
    rhd = np.mean(np.min(D,axis=1))
    return max(fhd,rhd) 
    
def hausdorff_symmetry(B):
    """given a binary image, compute modified hausdorff distance between
    its perimeter and its perimeter rotated 180, 90, and mirrored
    across its centroid in the up/down direction. intended to be used
    with binary regions rotated so that their major axis is horizontal.
    """
    cy, cx = regionprops(B)[0].centroid
    by, bx = np.where(find_perimeter(B))
    P = np.vstack((by,bx)).T - [[cy, cx]]
    P90 = np.roll(P,1,axis=1) # rotated 90 degrees
    P180 = P * -1 # rotated 180 degrees
    Pfud = P * [[-1, 1]] # reflected across major axis (up/down)
    return [modified_hausdorff(P,Q) for Q in [P180, P90, Pfud]]
