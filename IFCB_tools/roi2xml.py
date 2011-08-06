#!/usr/bin/python
import re
from sys import argv

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2xml [id] [dir: .] [outdir: .]'
    else:
        # allow id to be the ROI file name, strip off the .roi extension if it's there
        id = re.sub('(.*)\\.[a-z]+','\\1',argv[1])
        dir = '.'
        outdir = '.'
        arg = 2
        if(len(argv) > arg):
            dir = argv[arg]
            arg = arg + 1
        if(len(argv) > arg):
            outdir = argv[arg]
            arg = arg + 1
        