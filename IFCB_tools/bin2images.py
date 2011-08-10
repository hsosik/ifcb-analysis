#!/usr/bin/python
from ifcb.io.file import BinFile
import re
from sys import argv

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2images [id] [dir: .] [outdir: .] [format: png]'
    else:
        bin = BinFile(*argv[1:3]) # id, dir
        bin.save_images(*argv[3:5]) # outdir, format
