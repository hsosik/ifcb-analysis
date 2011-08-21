#!/usr/bin/python
from sys import argv, stdout
from ifcb.io.file import BinFile
from ifcb.io.dir import DayDir, YearsDir
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2xml, target2image, fs2json_feed, fs2html_feed, day2html, bin2html, target2html
import ifcb

J = Filesystem(['/Volumes/J_IFCB/ifcb_data_MVCO_jun06'])
E = Filesystem(['../exampleData'])

def test1():
    for sfx in ['157_181359', '188_200152', '214_150922', '237_000054']:
        bin = BinFile('IFCB1_2006_'+sfx,r'../exampleData/headerFiles')
        print bin.headers()

def test2():
    dd = DayDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06/IFCB1_2010_193')
    print [bin.iso8601time() for bin in dd.all_bins()]
    
def test3():
    yd = YearsDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06','[15]')
    print [d.pid() for d in yd.all_days()]

def test4():
    pid = ifcb.pid('IFCB5_2011_056_024112')
    print J.bin(pid)

def test5():
    pid = ifcb.pid('IFCB5_2011_056_024112_000001')
    print J.target(pid)
    
def test6():
    bin = BinFile('../exampleData/IFCB1_2011_231_182610.adc')
    #bin2xml(BinFile('../exampleData/IFCB1_2011_231_182610.adc'))
    for target in bin:
        print target.info
        target2image(target,'PNG','/tmp/foo.png')

def test7():
    target2html(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2009_216_075913_00249'))
    bin2html(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2009_216_075913'))
    day2html(E.resolve('http://ifcb-data.whoi.edu/IFCB1_2009_216'))
    
if __name__ == '__main__':
    test7()
