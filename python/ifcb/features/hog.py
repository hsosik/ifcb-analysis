import numpy as np
from numpy.linalg import norm

from skimage import img_as_float
from scipy import ndimage as ndi
from scipy.ndimage.filters import correlate

def image_hog(image):
    nwin_x = 3 # set here the number of HOG windows per bound box
    nwin_y = 3
    B = 9 # set here the number of histogram bins
    L, C = image.shape # L num of lines ; C num of columns
    H = np.zeros((nwin_x*nwin_y, B)) # result vector
    m = np.sqrt(L/2)

    # convert to float, retain uint8 range
    Im = img_as_float(image) * 255.

    step_x = int(np.floor(C/(nwin_x+1)))
    step_y = int(np.floor(L/(nwin_y+1)))

    # correlate image with orthogonal gradient masks
    hx = [[-1,0,1]];
    hy = np.rot90(hx);
    
    grad_xr = correlate(Im,hx,mode='constant')
    grad_yu = correlate(Im,hy,mode='constant')
    
    # compute orientation vectors
    angles = np.arctan2(grad_yu,grad_xr)
    magnit = np.sqrt(grad_yu**2 + grad_xr**2)
    
    # compute histogram
    cont = 0
    for n in range(nwin_y):
        for m in range(nwin_x):
            # subset angles and magnitudes
            angles2 = angles[n*step_y:(n+2)*step_y, m*step_x:(m+2)*step_x]
            magnit2 = magnit[n*step_y:(n+2)*step_y, m*step_x:(m+2)*step_x]
            v_angles = angles2.reshape((-1,1))
            v_magnit = magnit2.reshape((-1,1))
            K = v_angles.shape[0]
            # assembling the histogram with 9 bins (range of 20 degrees per bin)
            H2 = np.zeros((B))
            for b, ang_lim in zip(range(B), np.linspace(0-np.pi+2*np.pi/B, np.pi, B)):
                # for angles in this angle bin, accumulate magnitude
                H2[b] = H2[b] + np.sum(v_magnit[v_angles < ang_lim])
                # exclude this angle bin from further iterations
                v_angles[v_angles < ang_lim] = 999
            # normalize
            H2 /= (norm(H2)+0.01)
            H[cont,:] = H2
            cont += 1
    
    # flatten results into row vector of size B * nwin_x * nwin_y
    return H.ravel()
