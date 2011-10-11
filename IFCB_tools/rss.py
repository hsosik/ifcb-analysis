#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
from ifcb.io.convert import fs2atom, fs2json_feed, fs2html_feed, fs2rss
from ifcb.io.path import Filesystem
from config import FS_ROOTS, FEED
import time
import re

"""Produce an RSS or ATOM feed of bins"""

if __name__ == '__main__':
    cgitb.enable()
    format = cgi.FieldStorage().getvalue('format','atom') # default format is atom
    size = int(cgi.FieldStorage().getvalue('n','25')) # default number of bins to return is 25
    date = None
    dates = cgi.FieldStorage().getvalue('date',None) # default date is now
    if dates is not None and dates != 'now':
        if re.match(r'^\d{4}-\d{2}-\d{2}$',dates): # is it an unadorned yyyy-mm-dd?
            date = time.strptime(dates+'UTC','%Y-%m-%d%Z') # assume midnight UTC
        elif re.match(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$',dates): # ISO 8601 in YYYY-mm-ddTHH:MM:SSZ?
            date = time.strptime(re.sub('Z$','UTC',dates),'%Y-%m-%dT%H:%M:%S%Z') # parse
    # compute MIME type
    mime = dict(atom='application/atom+xml', json='application/json', html='text/html', rss='application/rss+xml')[format]
    headers = ['Content-type: %s' % mime,
               'Cache-control: max-age=60',
               '']
    for h in headers:
        print h
    link = '.'.join([FEED,format])
    # convert to feed
    dict(atom=fs2atom, json=fs2json_feed, html=fs2html_feed, rss=fs2rss)[format](Filesystem(FS_ROOTS),link,size,date)
