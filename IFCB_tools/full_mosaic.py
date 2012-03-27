from sys import argv
import mosaic

import ifcb
from ifcb.io.file import BinFile
from ifcb.io.path import Filesystem
from ifcb.io import HEIGHT, WIDTH, TARGET_NUMBER, PID, PROCESSING_END_TIME
from config import FS_ROOTS, DATA_TTL

if __name__=='__main__':
    pid = argv[1]
    print 'Resolving...'
    bin = Filesystem(FS_ROOTS).resolve(pid) # fetch the bin
    nrois = bin.length()
    width = 2400
    height = nrois * 4
    while True:
        print 'Fitting ...'
        lo = mosaic.layout(bin, (width, height), sort_key=lambda t: t.processingEndTime)
        nfit = len(lo['tiles'])
        print 'Fit %d of %d ROIs in a %d x %d mosaic...' % (nfit, nrois, width, height)
        if nfit < nrois:
            height = int(height * 1.5)
        else:
            print 'Computing image...'
            image = mosaic.mosaic(bin, (width, height), existing_layout=lo)
            thumb_width = 1024;
            thumb_height = int(round(0.426667 * height))
            print 'downscaling to %d x %d ...' % (thumb_width, thumb_height)
            thumb = mosaic.thumbnail(image, (thumb_width, thumb_height))
            (ext, fmt) = ('.jpg', 'JPEG')
            fn = ifcb.lid(pid) + ext
            print 'saving to disk in %s...' % fn
            with open(fn, 'wb') as out:
                thumb.save(fn, fmt)
            break
