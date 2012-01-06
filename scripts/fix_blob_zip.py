from sys import argv
from os import makedirs, path
import re
from zipfile import ZipFile

# the weekend ... starts here
(pid, outdir) = argv[1:]
indir = '/scratch/ifcb'
blobdir = '/scratch/ifcb/blobs'
(day, year) = re.match(r'IFCB._((\d+)_\d+)_\d+',pid).groups()
try:
    makedirs(path.join(outdir,year,day))
except:
    pass
binzip = path.join(indir,year,day,pid+'.zip')
badblobzip = path.join(blobdir,year,day,pid+'_blobs.zip')
goodblobzip = path.join(outdir,year,day,pid+'_blobs_v2.zip')

# now open all three files.
try:
    bin = ZipFile(binzip,'r')
    bad = ZipFile(badblobzip,'r')
    good = ZipFile(goodblobzip,'w')
    # first entries are csv and xml records
    for name in bin.namelist()[:2]:
        good.writestr(name, bin.read(name))
    # compare bin names (right) with blob zip names (wrong)
    for (right,wrong) in zip(bin.namelist()[2:], bad.namelist()):
        bytes = bad.read(wrong) # right data, wrong name
        good.writestr(right,bytes) # now it has the right name
except:
    raise

good.close()
                






