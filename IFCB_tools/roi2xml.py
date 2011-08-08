#!/usr/bin/python
from sys import argv, stdout
from ifcb.io.file import RoiFile
from ifcb.io.convert import rois2xml

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2xml [id] [dir: .]'
    else:
        rois2xml(RoiFile(*argv[1:]),stdout)
        