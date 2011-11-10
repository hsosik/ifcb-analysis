#!/usr/bin/python
from sys import argv, stdout
import io
from array import array
from ifcb.io.file import BinFile
from ifcb.io.dir import DayDir, YearsDir
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2xml, target2image, fs2json_feed, fs2html_feed, fs2atom, fs2rss, day2html, bin2html, target2html, target2xml, target2json, target2rdf, bin2json, day2rdf, day2xml, day2json, bin2hdr, bin2adc, bin2roi
import ifcb
import pickle
from config import FEED
from mosaic import doit

import urllib2 as urllib
from PIL import Image
from cStringIO import StringIO

J = Filesystem(['/Volumes/J_IFCB/ifcb_data_MVCO_jun06'])
E = Filesystem(['../exampleData'])

def test1():
    for sfx in ['157_181359', '188_200152', '214_150922', '237_000054']:
        bin = BinFile('../exampleData/headerFiles/IFCB1_2006_'+sfx)
        print bin.headers()

def test2():
    dd = DayDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06/IFCB1_2010_193')
    day2html(dd)
    day2json(dd)
    day2xml(dd)
    day2rdf(dd)
    print [bin.iso8601time for bin in dd.all_bins()]
    
def test3():
    yd = YearsDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06','[15]')
    print [d.pid for d in yd.all_days()]

def test4():
    bin = J.bin(ifcb.pid('IFCB5_2011_056_024112'))
    bin2html(bin)
    bin2json(bin)
    print ''
    bin2xml(bin)
    bin2adc(bin)
    bin2hdr(bin)

def test5():
    target = J.target(ifcb.pid('IFCB5_2011_056_024112_000001'))
    target2xml(target)
    target2html(target)
    target2rdf(target)
    
def test6():
    pass

def test7():
    day2html(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2009_216'))
    bin2html(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2011_231_182610'))
    target2json(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2009_216_075913_00249'))
    print len(pickle.dumps(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2011_231_182610').all_targets(),2))
    
def test8():
    pid = 'http://ifcb-data.whoi.edu/IFCB1_2011_231_182610_09147'
    target_png = E.resolve(pid)
    with open('/Users/jfutrelle/Pictures/bad2.png','w') as f:
        target2image(target_png,'png', f)

def test9():
    fs2atom(E,FEED+'.atom')
    fs2rss(E,FEED+'.rss')

def test10():
    pid = 'http://ifcb-data.whoi.edu/IFCB1_2009_216_075913'
    with open('/tmp/bar.jpg','wb') as out:
        doit(pid, 'medium', 'jpg', out, ['../exampleData'])

def test11():
    img_file = urllib.urlopen('http://ifcb-data.whoi.edu/IFCB5_2010_264_124252_01179.png')
    im = Image.open(StringIO(img_file.read()))
    im.save('/Users/jfutrelle/Pictures/foo.png','PNG')

if __name__ == '__main__':
    """
    test1()
    test2()
    test3()
    test4()
    test5()
    test6()
    test7()
    test8()
    test9()
    test10()
    """
    test11()
    
