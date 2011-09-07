#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
from ifcb.io.convert import fs2atom, fs2json_feed, fs2html_feed
from ifcb.io.path import Filesystem
from config import FS_ROOTS, FEED
import time
import re

if __name__ == '__main__':
    cgitb.enable()
    format = cgi.FieldStorage().getvalue('format','atom')
    size = int(cgi.FieldStorage().getvalue('n','25'))
    date = None
    dates = cgi.FieldStorage().getvalue('date',None)
    if dates is not None and dates != 'now':
        if re.match(r'^\d{4}-\d{2}-\d{2}$',dates):
            date = time.strptime(dates+'UTC','%Y-%m-%d%Z')
        elif re.match(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$',dates):
            date = time.strptime(dates+'UTC','%Y-%m-%dT%H:%M:%S%Z')
    mime = dict(atom='application/atom+xml', json='application/json', html='text/html')[format]
    print 'Content-type: %s\n' % (mime)
    link = '.'.join([FEED,format])
    dict(atom=fs2atom, json=fs2json_feed, html=fs2html_feed)[format](Filesystem(FS_ROOTS),link,size,date)
