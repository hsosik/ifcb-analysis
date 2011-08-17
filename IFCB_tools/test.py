#!/usr/bin/python
from sys import argv, stdout
from ifcb.io.file import BinFile
from ifcb.io.dir import DayDir, YearsDir
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2xml
import ifcb

def test1():
    for sfx in ['157_181359', '188_200152', '214_150922', '237_000054']:
        bin = BinFile('IFCB1_2006_'+sfx,r'../exampleData/')
        print bin.headers()

def test2():
    dd = DayDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06/IFCB1_2010_193')
    print [bin.iso8601time() for bin in dd.all_bins()]
    
def test3():
    yd = YearsDir('/Volumes/J_IFCB/ifcb_data_MVCO_jun06','[15]')
    print [d.pid() for d in yd.all_days()]

def test4():
    fs = Filesystem(['/Volumes/J_IFCB/ifcb_data_MVCO_jun06'])
    pid = ifcb.pid('IFCB5_2011_056_024112')
    print fs.bin(pid)

def test5():
    fs = Filesystem(['/Volumes/J_IFCB/ifcb_data_MVCO_jun06'])
    pid = ifcb.pid('IFCB5_2011_056_024112_000001')
    print fs.target(pid)
    
if __name__ == '__main__':
    test5()
