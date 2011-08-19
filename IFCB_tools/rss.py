#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
from ifcb.io.convert import fs2atom
from config import FS, ATOM

if __name__ == '__main__':
    cgitb.enable()
    print 'Content-type: application/atom+xml\n'
    fs2atom(FS,ATOM)
        
