import numpy as np

from scipy.ndimage.morphology import distance_transform_edt

from oii.ifcb2.features.morphology import find_perimeter

def distmap_volume(B,perimeter_image=None):
    """Moberg & Sosik biovolume algorithm
    returns volume and representative transect"""
    if perimeter_image is None:
        perimeter_image = find_perimeter(B)
    D = distance_transform_edt(1-perimeter_image) + 1
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
    # return volume and representative transect
    return volume, x
    
def sor_volume(B):
    """solid of rotation method"""
    """known as volumewalk in Moberg / Sosik code"""
    C = np.sum(B.astype(np.bool),axis=0) * 0.5
    return np.sum(C**2 * np.pi)

# the following represents how SOR volumes are computed in v2 features
def sor_volume_v2(B):
    S = np.sum(B,axis=0) > 0
    C = np.argmax(B,axis=0)
    C2 = (B.shape[0] - np.argmax(np.flipud(B),axis=0)) * S
    H = (C2-C) * 0.5
    return np.sum(H**2 * np.pi)
