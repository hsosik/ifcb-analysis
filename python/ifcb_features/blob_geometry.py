import numpy as np

from numpy.linalg import eig

from scipy.spatial import ConvexHull
from scipy.spatial.distance import pdist

from skimage.draw import polygon, line
from skimage.measure import regionprops

def blob_area(B):
    return np.sum(np.array(B).astype(np.bool))
    
def blob_extent(B,area=None):
    if area is None:
        area = blob_area(B)
    return float(area) / B.size

def equiv_diameter(area):
    return np.sqrt(4*area/np.pi)

def ellipse_properties(B):
    """returns major axis length, minor axis length, eccentricity,
    and orientation"""
    """note that these values are all computable using
    skimnage.measure.regionprops, which differs only in that
    it returns the orientation in radians"""
    P = np.vstack(np.where(B)) # coords of all points
    # magnitudes and orthonormal basis vectors
    # are computed via the eigendecomposition of
    # the covariance matrix of the coordinates
    eVal, eVec,  = eig(np.cov(P))

    # axes lengths are 4x the sqrt of the eigenvalues,
    # major and minor lenghts are max, min of them
    L = 4 * np.sqrt(eVal)
    maj_axis, min_axis = np.max(L), np.min(L)

    # orientation is derived from the major axis's
    # eigenvector
    x,y = eVec[:, np.argmax(L)]
    orientation = (180/np.pi) * np.arctan(y/x) - 90
    
    # eccentricity = 1st eccentricity
    ecc = np.sqrt(1-(min_axis/maj_axis)**2)
    
    return maj_axis, min_axis, ecc, orientation

def invmoments(B):
    """compute invariant moments. see
    Digital Image Processing Using MATLAB, ch. 11"""
    B = np.array(B).astype(np.float64)
    M, N = B.shape
    x, y = np.meshgrid(np.arange(1,N+1), np.arange(1,M+1))

    x = x.ravel()
    y = y.ravel()
    F = B.ravel()

    def m(p,q):
        xp = 1 if p==0 else x**p
        yq = 1 if q==0 else y**q
        return np.sum(xp * yq * F)
    
    m00 = m(0,0)

    x_ = x - (m(1,0) / m00)
    y_ = y - (m(0,1) / m00)
    
    mu_x = [1, x_] + [x_**p for p in [2,3]]
    mu_y = [1, y_] + [y_**p for p in [2,3]]
    
    def mu(p,q):
        return np.sum(mu_x[p] * mu_y[q] * F)

    mu00 = mu(0,0)

    def n(p,q): # eta sorta looks like n
        gamma = (p + q) / 2. + 1.
        return mu(p,q) / mu00**gamma

    # assign some variables so the eqns aren't impossible to read
    n20, n02 = n(2,0), n(0,2)
    n11 = n(1,1)
    n30, n03 = n(3,0), n(0,3)
    n12, n21 = n(1,2), n(2,1)
    
    phi1 = n20 + n02
    phi2 = (n20 - n02)**2 + 4 * n11**2
    phi3 = (n30 - 3 * n12)**2 + (3 * n21 - n03)**2
    phi4 = (n30 + n12)**2 + (n21 + n03)**2
    phi5 = (n30 - 3 * n12) * (n30 + n12) * \
        ( (n30 + n12)**2 - 3 * (n21 + n03)**2 ) + \
        (3 * n21 - n03) * (n21 + n03) * \
        ( 3 * (n30 + n12)**2 - (n21 + n03)**2 )
    phi6 = (n20 - n02) * \
        ( (n30 + n12)**2 - (n21 + n03)**2 ) + \
        4 * n11 * (n30 + n12) * (n21 + n03)
    phi7 = (3 * n21 - n03) * (n30 + n12) * \
        ( (n30 + n12)**2 - 3 * (n21 + n03)**2 ) + \
        (3 * n12 - n30) * (n21 + n03) * \
        ( 3 * (n30 + n12)**2 - (n21 + n03)**2 )

    return phi1, phi2, phi3, phi4, phi5, phi6, phi7

def convex_hull(perimeter_points):
    P = np.vstack(perimeter_points).T
    hull = ConvexHull(P)
    return P[hull.vertices]

def convex_hull_properties(hull):
    """compute perimeter and area of convex hull"""
    ab = hull - np.roll(hull,1,axis=0)
    # first compute length of each edge
    C = np.sqrt(np.sum(ab**2,axis=1))
    # perimeter is sum of these
    perimeter = np.sum(C)
    # compute distance from center to each vertex
    center = np.mean(hull,axis=0)
    A = np.sqrt(np.sum((hull - center)**2,axis=1))
    # A, B, C will now be all triangle edges
    B = np.roll(A,1,axis=0)
    # heron's forumla requires s = half of each triangle's perimeter
    S = np.sum(np.vstack((A,B,C)),axis=0) / 2
    # compute area of each triangle
    areas = np.sqrt(S * (S-A) * (S-B) * (S-C))
    # area of convex hull is sum of these
    area = np.sum(areas)
    # add half-pixel adjustment for each unit distance along
    # perimeter to adjust for rasterization
    area += perimeter / 2
    return perimeter, area
    
def convex_hull_perimeter(hull):
    perimeter, _ = convex_hull_properties(hull)
    return perimeter

def convex_hull_area(hull):
    _, area = convex_hull_properties(hull)
    return area
    
def feret_diameter(hull):
    D = pdist(hull)
    return np.max(D)

def convex_hull_image(hull,shape):
    """this can also be computed using
    skimage.measure.regionprops"""
    chi = np.zeros(shape,dtype=np.bool)
    # points in the convex hull
    y, x = polygon(hull[:,0], hull[:,1])
    chi[y,x] = 1
    # points on the convex hull
    for row in np.hstack((hull, np.roll(hull,1,axis=0))):
        chi[line(*row)]=1
    return chi

def feret_diameters(hull):
    """return min and max feret diameters"""
    y, x = hull.astype(np.float64).T
    def do_angles():
        for theta in np.linspace(0,-359,360) * (np.pi / 180.):
            cos_theta = np.cos(theta)
            sin_theta = np.sin(theta)
            x2 = x * cos_theta - y * sin_theta
            dl = np.abs(cos_theta) + np.abs(sin_theta)
            yield np.max(x2) - np.min(x2) + dl
    m = list(do_angles())
    return np.min(m), np.max(m)
    
def binary_symmetry(B):
    # binary symmetry. should be passed a blob image
    # centered on the blob's centroid and rotated
    # so that the blob's major axis is horizontal
    area = np.sum(B)
    def ss(D):
        return 1. * np.sum(np.logical_and(B,D)) / area
    # now compute ratio of pixels in overlap to area
    # for three different geometric transformations
    # rotation 180 degrees
    b180 = ss(np.rot90(B,2))
    # rotation 90 degrees
    b90 = ss(np.rot90(B))
    # flipped across horizontal (major) axis
    bflip = ss(np.flipud(B))
    return b180, b90, bflip

