import ifcb
import re
from zipfile import ZipFile
from config import BLOB_ROOTS, DATA_TTL
from os import path
from sys import stdout
from shutil import copyfileobj
from ifcb.io.pids import parse_id

def zip_path(pid):
    oid = parse_id(pid)
    bin = oid.bin_lid
    day = oid.yearday
    year = oid.year
    tried = []
    for blob_root in BLOB_ROOTS:
        blobzip = path.join(blob_root,year,day,bin+'_blobs_v2.zip')
        if path.exists(blobzip):
            return blobzip
        tried += [blobzip]
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
