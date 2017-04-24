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
    Im = image.astype(np.float)

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
    ang_high = np.linspace(0-np.pi+2*np.pi/B, np.pi, B)
    ang_low = np.roll(ang_high,1)
    ang_low[0] = np.min(ang_high) - 999.
    bin_iter = zip(range(B), ang_low, ang_high)
    for n in range(nwin_y):
        for m in range(nwin_x):
            # subset angles and magnitudes
            angles2 = angles[n*step_y:(n+2)*step_y, m*step_x:(m+2)*step_x]
            magnit2 = magnit[n*step_y:(n+2)*step_y, m*step_x:(m+2)*step_x]
            v_angles = angles2.ravel()
            v_magnit = magnit2.ravel()
            # assembling the histogram with 9 bins (range of 20 degrees per bin)
            H2 = np.zeros((B))
            for b, low, high in zip(range(B), ang_low, ang_high):
                # for angles in this angle bin, accumulate magnitude
                H2[b] += np.sum(v_magnit[np.logical_and(v_angles >= low, v_angles < high)])
            # normalize
            H2 /= (norm(H2)+0.01)
            H[cont,:] = H2
            cont += 1
    
    # flatten results into row vector of size B * nwin_x * nwin_y
    return H.ravel()
