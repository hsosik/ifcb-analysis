import ifcb
import re
from zipfile import ZipFile
from config import BLOB_ROOTS, DATA_TTL
from os import path
from sys import stdout
from shutil import copyfileobj

def zip_path(pid):
    lid = ifcb.lid(pid)
    (bin, day, year) = re.match(r'(IFCB._((\d+)_\d+)_\d+).*',lid).groups()
    for blob_root in BLOB_ROOTS:
        blobzip = path.join(blob_root,year,day,bin+'_blobs_v2.zip')
        if path.exists(blobzip):
            return blobzip
    raise KeyError(pid+' blob not found')

# write the blob zip to out
def pid2blobzip(pid, out=stdout):
   with open(zip_path(pid)) as z:
        copyfileobj(z, out)
        out.flush()

# return the bytes of a png
def pid2blobpng(pid):
    lid = ifcb.lid(pid)
    blobzip = ZipFile(zip_path(lid))
    png = blobzip.read(lid+'.png')
    blobzip.close()
    return png
