#!/usr/bin/python
from sys import argv, stdout
from ifcb.io.file import BinFile
from ifcb.io.convert import bin2json

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: bin2xml [file]'
    else:
        bin2json(BinFile(argv[1]),stdout,True)
