#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
import resolve
import rss
import mosaic
from spider.dashboard import spider

if __name__ == '__main__':
    cgitb.enable()
    print 'Content-type: text/plain\n'
    spider()
    print 'done'
