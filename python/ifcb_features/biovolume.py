import numpy as np

from scipy.ndimage.morphology import distance_transform_edt

from .morphology import find_perimeter

def bottom_top_area(X,Y,Z,ignore_ground=False):
    """computes top quad and bottom quad areas for distmap
    and SOR algorithms"""
    """ignore_ground is an adjustment used in distmap
    but not in SOR"""
    h, w = Z.shape

    i2 = slice(0,h-1)
    i1 = slice(1,h)
    ia2 = slice(0,w-1)
    ia1 = slice(1,w)
    
   # create linesegs AB for all quadrilaterals
    AB1, AB2, AB3 = [xyz[i2,ia2] - xyz[i1,ia2] for xyz in [X,Y,Z]]
    # create linesegs AD for all quadrilaterals
    AD1, AD2, AD3 = [xyz[i2,ia2] - xyz[i1,ia1] for xyz in [X,Y,Z]]
    # create linesegs AD for all quadrilaterals
    CD1, CD2, CD3 = [xyz[i2,ia1] - xyz[i1,ia1] for xyz in [X,Y,Z]]

    # triangle formed by AB and AD for all quadrilaterals
    leg1 = ((AB2 * AD3) - (AB3 * AD2)) ** 2
    leg2 = ((AB3 * AD1) - (AB1 * AD3)) ** 2
    leg3 = ((AB1 * AD2) - (AB2 * AD1)) ** 2
    # bottom area
    area_bot = 0.5 * np.sqrt(leg1 + leg2 + leg3)

    # triangle formed by CD and AD for all quadrilaterals
    leg1 = ((CD2 * AD3) - (CD3 * AD2)) ** 2
    leg2 = ((CD3 * AD1) - (CD1 * AD3)) ** 2
    leg3 = ((CD1 * AD2) - (CD2 * AD1)) ** 2
    # top area
    area_top = 0.5 * np.sqrt(leg1 + leg2 + leg3)
    
    if ignore_ground:
        ind = np.abs(AB3) + np.abs(AD3) + np.abs(CD3) + Z[i2,ia2]
        area_bot[ind==0] = 0
        area_top[ind==0] = 0
        
    return area_bot, area_top

def distmap_volume_surface_area(B,perimeter_image=None):
    """Moberg & Sosik biovolume algorithm
    returns volume and representative transect"""
    if perimeter_image is None:
        perimeter_image = find_perimeter(B)
    # elementwise distance to perimeter + 1
    D = distance_transform_edt(1-perimeter_image) + 1
    # mask distances outside blob
    D = D * (B>0)
    Dm = np.ma.array(D,mask=1-B)
    # representative transect
    x = 4 * np.ma.mean(Dm) - 2
    # diamond correction
    c1 = x**2 / (x**2 + 2*x + 0.5)
    # circle correction
    # c2 = np.pi / 2 
    # volume = c1 * c2 * 2 * np.sum(D)
    volume = c1 * np.pi * np.sum(D)
    # surface area
    h, w = D.shape
    Y, X = np.mgrid[0:h,0:w]
    area_bot, area_top = bottom_top_area(X,Y,D,ignore_ground=True)
    # final correction of the diamond cross-section
    # inherent in the distance map to be circular instead
    c = (np.pi * x / 2) / (2 * np.sqrt(2) * x / 2 + (1 + np.sqrt(2)) / 2)
    sa = 2 * c * (np.sum(area_bot) + np.sum(area_top))
    # return volume, representative transect, and surface area
    return volume, x, sa

def sor_volume_surface_area(B):
    """pass in rotated blob"""
    """Sosik and Kilfoyle surface area / volume algorithm"""
    # find the bottom point of the circle for each column
    m = np.argmax(B,axis=0)
    # compute the radius of each slice
    d = np.sum(B,axis=0)
    # exclude 0s
    r = (d/2.)[d>0]
    m = m[d>0]
    n_slices = r.size
    # compute 721 angles between 0 and 180 degrees inclusive, in radians
    n_angles = 721
    angR = np.linspace(0,180,n_angles) * (np.pi / 180)
    
    # make everything the same shape: (nslices, nangles)
    angR = np.vstack([angR] * m.size)
    m = np.vstack([m] * n_angles).T
    r = np.vstack([r] * n_angles).T
    
    # compute the center of each slice
    center = m + r
    # correct for edge effects
    center[0,:]=center[1,:]
    center[-1,:]=center[-2,:]
    
    # y coordinates of all angles on all slices
    Y = center + np.cos(angR) * r
    # z coordinates of all angles on all slices
    Z = np.sin(angR) * r
    
    # compute index of slice in y matrix
    x = np.array(range(r.shape[0])) + 1.
    # half-pixel adjustment of edges
    x[0]-=0.5
    x[-1]+=0.5
    X = np.vstack([x] * n_angles).T
    
    # compute bottom and top area
    area_bot, area_top = bottom_top_area(X,Y,Z)
    
    # surface area
    # multiply sum of areas of quadrilaterals by 2 to account for angles 180-360
    sa = 2 * (np.sum(area_bot) + np.sum(area_top))
    # add flat end caps
    sa += np.sum(np.pi * r[[0,-1],0]**2)
    
    # compute height of cone slices
    b1 = np.pi * r[1:n_slices,0] ** 2
    b2 = np.pi * r[0:n_slices-1,0] ** 2
    h = np.diff(x)
    # volume
    v = np.sum((h/3) * (b1 + b2 + np.sqrt(b1 * b2)))
    
    # representative width
    xr = np.mean(r[:,0]*2)
    
    # return volume, representative width, and surface area
    return v, xr, sa
    
