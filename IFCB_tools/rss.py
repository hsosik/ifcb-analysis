#!/usr/bin/python
from sys import argv, stdout
import cgi
from ifcb.db.feed import latest_bins, day_bins
from ifcb.io.convert import bins2atom, bins2json_feed, bins2html_feed, bins2rss
from ifcb.io.path import Filesystem
from config import FS_ROOTS, FEED
import re
import time
import datetime

if __name__=='__main__':
    format = cgi.FieldStorage().getvalue('format','atom') # default format is atom
    size = int(cgi.FieldStorage().getvalue('n','25')) # default number of bins to return is 25
    date = None
    dates = cgi.FieldStorage().getvalue('date',None) # default date is now
    if dates is not None and dates != 'now':
        if re.match(r'^\d{4}-\d{2}-\d{2}$',dates): # is it an unadorned yyyy-mm-dd?
            date = time.strptime(dates+'UTC','%Y-%m-%d%Z') # assume midnight UTC
        elif re.match(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$',dates): # ISO 8601 in YYYY-mm-ddTHH:MM:SSZ?
            date = time.strptime(re.sub('Z$','UTC',dates),'%Y-%m-%dT%H:%M:%S%Z') # parse
    dayss = cgi.FieldStorage().getvalue('day',None)
    if dayss is not None:
        if re.match(r'^\d{4}-\d{2}-\d{2}$',dayss): # is it an unadorned yyyy-mm-dd?
            date = time.strptime(dayss+'UTC','%Y-%m-%d%Z') # assume midnight UTC
        elif re.match(r'^\d{4}-\d{3}$',dayss): # is it a julian day (yyyy-jjj)?
            date = time.strptime(dayss+'UTC','%Y-%j%Z')
    fs = Filesystem(FS_ROOTS)
    if dayss is not None:
        bin_ids = list(day_bins(date))
    else:
        bin_ids = list(latest_bins(size,date))
    bins = [fs.resolve(pid) for pid in bin_ids]
    mime = dict(atom='application/atom+xml', json='application/json', html='text/html', rss='application/rss+xml')[format]
    headers = ['Content-type: %s' % mime,
               'Cache-control: max-age=60',
               '']
    for h in headers:
        print h
    link = '.'.join([FEED,format])
    if format == 'atom':
        bins2atom(bins,link)
    elif format == 'json':
        bins2json_feed(bins)
    elif format == 'rss':
        bins2rss(bins,link)
    elif format == 'html':
        bins2html_feed(bins)
