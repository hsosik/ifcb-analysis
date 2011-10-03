#!/usr/bin/python
import cgitb
from ifcb.io.path import Filesystem
from config import FS_ROOTS
import sys

if __name__ == '__main__':
    cgitb.enable()
    fs = Filesystem(FS_ROOTS)
    print 'Content-type: text/plain\n'
    for day in fs.all_days():
        print 'I know about some data'
        sys.exit(2)
    else:
        print 'I cannot find any data'