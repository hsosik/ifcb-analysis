import ifcb
from ifcb.io.client import Client
from ifcb.stitching import stitch, find_pairs
import os
import sys
    
def test_bin(pid):
    client = Client()
    catch = False
    dir = os.path.join('stitch',ifcb.lid(pid))
    try:
        os.mkdir(dir)
    except:
        pass
    os.chdir(dir)
    bin = client.resolve(pid)
    for t1,t2 in find_pairs(bin):
        try:
            (s,mask,edges) = stitch([t1,t2])
            print 'Stitched %s and %s' % (t1.pid, t2.pid)
            basename = ifcb.lid(t1.pid)
            s.save(basename+'.png','png')
            mask.save(basename+'_mask.png','png')
            edges.save(basename+'_edge.png','png')
        except:
            if catch:
                print 'Error stitching: "%s" for %s and %s' % (sys.exc_info()[0], pid1, pid2)
            else:
                raise
        
if __name__=='__main__':
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_294_114650')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_282_235113')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_121939')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_287_152253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_295_022253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_121647')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_135001')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_242_133222')
    test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_150210')