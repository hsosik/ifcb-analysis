#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
import resolve
import rss
import mosaic
from spider.dashboard import spider
from ifcb.db.bins2db import bins2db
from ifcb.io.path import Filesystem
from config import FS_ROOTS

if __name__ == '__main__':
    cgitb.enable()
    print 'Content-type: text/plain\n'
    bins2db(Filesystem(FS_ROOTS))
    spider()
    print 'done'
