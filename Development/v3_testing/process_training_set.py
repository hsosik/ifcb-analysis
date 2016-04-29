import os
import logging
from multiprocessing import Pool

import numpy as np
import pandas as pd

from skimage.io import imread
from scipy.io import savemat

from ifcb.features import Roi, get_all_features, N_FEATURES

logging.basicConfig(level=logging.DEBUG)

CSV='/mnt/lab_data/Futrelle/training_set.csv'
IMG_DIR='/mnt/ifcb_products/MVCO/MVCO_train_Aug2015'
OUT_DIR='/mnt/lab_data/Futrelle/test'

CHUNK_SIZE=10

def read_training_set():
    logging.info('reading training set...')
    return pd.read_csv(CSV, names=['class','lid'])

def read_roi_image(cls, lid):
    img_path = os.path.join(IMG_DIR, cls, '%s.png' % lid)
    return imread(img_path)

def do_chunk(ts, chunk_no, chunk_size=CHUNK_SIZE):
    ix = lambda i: (chunk_no * chunk_size) + i
    size = ts.shape[0]
    first = ix(0)
    last = min(size, ix(chunk_size))
    classes = ts['class'][first:last]
    lids = ts['lid'][first:last]
    features = np.zeros((last-first, N_FEATURES-1)) # exclude roi_number
    featitles = None
    for j in range(chunk_size):
        i = ix(j)
        if i >= size:
            break
        cls, lid = ts['class'][i], ts['lid'][i]
        logging.info('%05d/%05d %s %s' % (i+1, size, cls, lid))
        img = read_roi_image(cls, lid)
        roi = Roi(img)
        roi_features = get_all_features(roi)
        ft, f = zip(*roi_features)
        if featitles is None:
            featitles = np.asarray(ft,dtype=object)
        features[:,:] = f
    out_path = os.path.join(OUT_DIR,'py_v3_ts_%05d_%05d.mat' % (ix(0)+1, ix(chunk_size)))
    logging.info('saving to %s...' % out_path)
    savemat(out_path, {
        'featitles': featitles,
        'classes': np.asarray(classes,dtype=object),
        'feature_mat': features,
        'pid': np.asarray(lids,dtype=object)
    })

def scatter(fn,argses,callback=None,processes=None):
    """Extremely simple multiprocessing.
    Parameters:
    fn - the function to apply
    argses - a list of argument lists for that function
    callback (optional) - a callback to receive results.
    processes (optional) - how many simultaneous processes to run."""
    pool = Pool(processes=processes)
    for args in argses:
        pool.apply_async(fn,args,{},callback)
    pool.close()
    pool.join()

def do_all():
    ts = read_training_set()
    for chunk in range(11):
        do_chunk(ts, chunk)

def do_test():
    ts = read_training_set()
    argses = [(ts,i) for i in range(10)]
    scatter(do_chunk, argses, processes=4)

if __name__=='__main__':
    do_test()

