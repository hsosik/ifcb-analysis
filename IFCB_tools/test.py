#!/usr/bin/python
from sys import argv, stdout
from ifcb.io.file import BinFile
from ifcb.io.dir import DayDir, YearsDir
from ifcb.io.convert import bin2xml

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

class Testy:
    range = 10
    
    def __iter__(self):
        for i in range(self.range):
            yield i

    def all_items(self):
        list(self)
        
def test4():
    t = Testy()
    print list(t)
    
if __name__ == '__main__':
    test4()
