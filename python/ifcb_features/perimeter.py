import numpy as np

from scipy.spatial import cKDTree
from scipy.spatial.distance import pdist, cdist
from scipy import stats

from skimage.measure import regionprops

from .morphology import find_perimeter
from .random import simple_prng

def hist_stats(arr):
    """returns mean, median, skewness, and kurtosis"""
    arr = np.array(arr).flatten()
    mean = np.mean(arr)
    median = np.median(arr)
    skewness = stats.skew(arr)
    kurtosis = stats.kurtosis(arr,fisher=False)
    return mean, median, skewness, kurtosis

def subsample_dist(A,max_n=10000):
    """subsampling version of pdist"""
    # take a min of n**2 and max of max_n samples
    n = A.shape[0]
    m = min(n**2,max_n)
    # now determinstically randomly sample pairs of points
    # sort the points
    six = np.argsort(np.sum(A * [np.max(A[:,1]),1],axis=1))
    pp = A[six,:]
    # sample m pairs with replacement
    ix = simple_prng(n,shape=(m,2))
    # compute euclidean distance between pairs
    spp_a = pp[ix[:,0],:]
    spp_b = pp[ix[:,1],:]
    return np.sqrt(np.sum((spp_a - spp_b)**2,axis=1))
    
def perimeter_stats(points, equiv_diameter):
    """compute stats of pairwise distances
    between all given points, given an
    equivalent diameter.
    returns mean, median, skewness, and kurtosis
    """
    B = np.vstack(points).T
    #D = subsample_dist(B) / equiv_diameter # FIXME use this
    # in H Sosik's v2 the square form is used,
    # use the short form here
    D = subsample_dist(B) / equiv_diameter
    return hist_stats(D)

def _pairwise_nearest(A,B):
    # compute distance to nearest neighbor from A to B
    D1, _ = cKDTree(A).query(B,k=1)
    # compute distance to nearest neighbor from B to A
    D2, _ = cKDTree(B).query(A,k=1)
    return D1, D2
    
def hausdorff(A,B):
    """compute the Hausdorff distance between two point sets"""
    D1, D2 = _pairwise_nearest(A,B)
    return max(np.max(D1),np.max(D2))
    
def modified_hausdorff(A,B):
    """compute the 'modified' Hausdorff distance between two
    point sets as described in
    M. P. Dubuisson and A. K. Jain. A Modified Hausdorff distance
    for object matching. In ICPR94, pages A:566-568, Jerusalem, Israel,
    1994.
    http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=576361
    """
    D1, D2 = _pairwise_nearest(A,B)
    return max(np.mean(D1),np.mean(D2))

def hausdorff_symmetry(B):
    """given a binary image, compute modified hausdorff distance between
    its perimeter and its perimeter rotated 180, 90, and mirrored
    across its centroid in the up/down direction. intended to be used
    with binary regions rotated so that their major axis is horizontal.
    """
    cy, cx = (np.array(B.shape)/2.)-1
    by, bx = np.where(find_perimeter(B))
    P = np.vstack((by,bx)).T - [[cy, cx]]
    P90 = np.roll(P,1,axis=1) # rotated 90 degrees
    P180 = P * -1 # rotated 180 degrees
    Pfud = P * [[-1, 1]] # reflected across major axis (up/down)
    return [modified_hausdorff(P,Q) for Q in [P180, P90, Pfud]]
