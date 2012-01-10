from sys import argv
from os import makedirs, path, uname
import re
from zipfile import ZipFile
from time import strftime, time, gmtime

QUEUE='blobfix20120106'
LOG_QUEUE=QUEUE+'_log'
FAIL_QUEUE=QUEUE+'_fail'

INDIR='/scratch/ifcb'
BLOBDIR='/scratch/ifcb/blobs'
OUTDIR='/scratch/ifcb/good_blobs'

# the weekend ... starts here
def fix(lid,skip=False):
    (day, year) = re.match(r'IFCB._((\d+)_\d+)_\d+',lid).groups()
    try:
        makedirs(path.join(OUTDIR,year,day))
    except:
        pass
    binzip = path.join(INDIR,year,day,lid+'.zip')
    badblobzip = path.join(BLOBDIR,year,day,lid+'_blobs.zip')
    goodblobzip = path.join(OUTDIR,year,day,lid+'_blobs_v2.zip')

    if skip and path.exists(goodblobzip):
        receipt = '%s blob_fix skipped %s on %s\n' % (utcnow, lid, ' '.join(uname()))
        return receipt

    # now open all three files.
    try:
        bin = ZipFile(binzip,'r')
        bad = ZipFile(badblobzip,'r')
        good = ZipFile(goodblobzip,'w')
    except:
        raise

    # first entries are csv and xml records
    for name in bin.namelist()[:2]:
        good.writestr(name, bin.read(name))
    # compare bin names (right) with blob zip names (wrong)
    for (right,wrong) in zip(bin.namelist()[2:], bad.namelist()):
        bytes = bad.read(wrong) # right data, wrong name
        good.writestr(right,bytes) # now it has the right name
    # now write a receipt
    utcnow = strftime('%Y-%m-%dT%H:%M:%SZ',gmtime(time()))
    receipt = '%s blob_fix %s on %s\n' % (utcnow, lid, ' '.join(uname()))
    good.writestr('receipt.txt', receipt)
    
    try:
        good.close()
        bad.close()
        bin.close()
    except:
        raise

    return receipt

if __name__=='__main__':
    lid = argv[1]
    fix(lid)
