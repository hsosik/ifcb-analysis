import os
import logging
import re

import numpy as np
import pandas as pd

from scipy.io import savemat

CSV='/mnt/lab_data/Futrelle/training_set.csv'
FEAT_DIR='/mnt/ifcb_products/MVCO/features'

logging.basicConfig(level=logging.DEBUG)

def read_training_set():
    logging.info('reading training set...')
    return pd.read_csv(CSV, names=['class','lid'])

ts = read_training_set()
n_rois = ts.shape[0]
logging.info('%d roi IDs read' % n_rois)

# compute bin lids
logging.info('resolving feature files')
ts['bin_lid'] = np.array([re.sub(r'_\d{5}$','',lid) for lid in ts['lid'][:]])
ts['roinum'] = np.array([int(re.sub(r'.*_(\d{5})$',r'\1',lid)) for lid in ts['lid'][:]])
ts.sort(['bin_lid','roinum'],inplace=True)

def feature_file_path(bin_lid):
    bin_year = re.sub(r'.*_(\d{4})_.*',r'\1',bin_lid)
    feature_file = '%s_fea_v2.csv' % bin_lid
    feature_path = os.path.join(FEAT_DIR,'features%s_v2' % bin_year,feature_file)
    return feature_path

all_features = None

for bin_lid, bin_rois in ts.groupby('bin_lid'):
    feature_path = feature_file_path(bin_lid)
    roinums = bin_rois['roinum']
    logging.info('processing %s...' % feature_path)
    bin_features = pd.read_csv(feature_path,index_col='roi_number')
    roi_features = bin_features.ix[roinums]
    roi_features['ts_index'] = bin_rois.index.values
    roi_features.set_index(['ts_index'],drop=True,inplace=True)
    roi_features['pid'] = bin_rois['lid']
    roi_features['class'] = bin_rois['class']
    if all_features is None:
        all_features = roi_features
    else:
        all_features = pd.concat([all_features, roi_features])
    logging.info('%d roi(s) added' % roi_features.shape[0])

logging.info('Done. Sorting data...')
all_features.sort(inplace=True)

pid = all_features.pop('pid')
cls = all_features.pop('class')
featitles = all_features.columns.values

logging.info('Saving compiled features...')
savemat('mat_v2_ts.mat', {
    'pid': np.asarray(pid,dtype=object),
    'classes': np.asarray(cls,dtype=object),
    'featitles': np.asarray(featitles,dtype=object),
    'feature_mat': np.asarray(all_features)
})
logging.info('All done!')
