import ifcb
import re
from zipfile import ZipFile
from config import BLOB_ROOTS, DATA_TTL
from os import path

# return the bytes of a png
def pid2blobpng(pid):
    lid = ifcb.lid(pid)
    (bin, day, year) = re.match(r'(IFCB._((\d+)_\d+)_\d+)',lid).groups()
    for blob_root in BLOB_ROOTS:
        try:
            blobzip = ZipFile(path.join(blob_root,year,day,bin+'_blobs_v2.zip'),'r')
            png = blobzip.read(lid+'.png')
            blobzip.close()
            return png
        except:
            pass
    raise KeyError(pid+' blob not found')
