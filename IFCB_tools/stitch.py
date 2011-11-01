import ifcb
from ifcb.io.client import Client
from ifcb.io.path import Filesystem
from ifcb.io.stitching import stitch, find_pairs, StitchedBin
import os
import sys

def test_bin(pid):
    client = Client()
    #client = Filesystem(['../exampleData'])
    catch = False
    dir = os.path.join('stitch',ifcb.lid(pid))
    try:
        os.mkdir(dir)
    except:
        pass
    os.chdir(dir)
    unstitched = client.resolve(pid)
    stitched = StitchedBin(unstitched)
    for target,ignore in find_pairs(unstitched):
        t = stitched.target(target.targetNumber)
        print 'Got %s' % t
        basename = ifcb.lid(t.pid)
        t.image().save(basename+'.png','png')

def test_rotate(pid):
    for client,fn in zip([Client(), Filesystem(['../exampleData'])],['target_web','target_file']):
        target = client.resolve(pid)
        print target.info
        fn = os.path.join('/Users/jfutrelle/Pictures',fn+'.png')
        target.image().save(fn,'png')
        print 'saved %s' % fn
        
if __name__=='__main__':
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_294_114650')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_282_235113')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_121939')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_287_152253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_295_022253')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_121647')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_273_135001')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_242_133222')
    #test_bin('http://ifcb-data.whoi.edu/IFCB1_2011_297_142938')
    #test_bin('http://ifcb-data.whoi.edu/IFCB5_2011_305_135951')
    test_bin('http://ifcb-data.whoi.edu/IFCB5_2010_264_102403')
