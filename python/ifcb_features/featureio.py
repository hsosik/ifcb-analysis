"""Reading and writing features"""
import os
from zipfile import ZipFile
import pandas as pd

from . import compute_features
from ifcb.data.imageio import format_image

def bin_features(the_bin, out_dir=None, log_callback=None, log_freq=500):
    bin_pid = the_bin.pid
    bin_lid = bin_pid.lid
    def log_msg(msg):
        msg = '[%s features] %s' % (bin_lid, msg)
        if log_callback is not None:
            log_callback(msg)
    blobs_path_basename = bin_lid + '_blobs_v3.zip'
    features_path_basename = bin_lid + '_features_v3.csv'
    blobs_path = os.path.join(out_dir, blobs_path_basename)
    features_path = os.path.join(out_dir, features_path_basename)
    n_rois = len(the_bin.images)
    features_dataframe = None
    n = 1
    log_msg('STARTING')
    try:
        with ZipFile(blobs_path,'w') as bout:
            for roi_number, image in the_bin.images.iteritems():
                # compute features
                roi_lid = bin_pid.with_target(roi_number)
                blobs_image, features = compute_features(image)
                # emit log message
                if n % log_freq == 0:
                    log_msg('PROCESSED %05d (%d of %d)' % (roi_number, n, n_rois))
                n += 1
                # write blob
                blob_entry_name = '%s.png' % roi_lid
                image_buf = format_image(blobs_image)
                image_bytes = image_buf.getvalue()
                image_buf.close()
                bout.writestr(blob_entry_name, image_bytes)
                # add features row to dataframe
                cols, values = zip(*features)
                cols = ('roiNumber',) + cols
                values = (roi_number,) + values
                values = [(value,) for value in values]
                row_df = pd.DataFrame({ c: v for c, v in zip(cols, values) },
                                      columns=cols)
                if features_dataframe is None:
                    features_dataframe = row_df
                else:
                    features_dataframe = features_dataframe.append(row_df)
            log_msg('closing %s' % blobs_path)
    except:
        # clean up incomplete blobs file
        if os.path.exists(blobs_path):
            log_msg('deleting %s' % blobs_path)
            os.remove(blobs_path)
        log_msg('FAILED')
        raise
    log_msg('writing %s' % features_path)
    float_fmt = '%.6f'
    features_dataframe.to_csv(features_path, index=None, float_format=float_fmt)
    log_msg('COMPLETED')
