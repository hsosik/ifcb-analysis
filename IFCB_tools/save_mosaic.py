from config import FS_ROOTS
from ifcb.io.path import Filesystem
import mosaic
import sys
import ifcb

if __name__=='__main__':
    if len(sys.argv) < 2:
        print >> sys.stderr, 'usage: %s [pid] [outputfile]' % sys.argv[0]
    else:
        fs = Filesystem(FS_ROOTS)
        b = fs.resolve(ifcb.pid(sys.argv[1]))
        outfile = None
        if len(sys.argv) > 2:
            outfile = sys.argv[2]
        print >> sys.stderr, 'Generating mosaic for %s' % str(b)
        mosaic.save_mosaic(b,outfile)
