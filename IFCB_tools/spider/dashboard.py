#!/usr/bin/python
from urllib2 import urlopen, HTTPError
import json
import re
import os
from shutil import copyfileobj
from config import DATA_NAMESPACE
from ifcb.util import log_msg

def lid(pid):
    return re.sub('http://[^/]+/','',pid)

def hit_url(url):
    log_msg('hitting ' + url + '...')
    try:
        u = urlopen(url)
        while True:
            b = u.read(2**20)
            if not b:
                break
        u.close()
    except HTTPError:
        pass

def spider(mosaics=7,bins=7):
    f = urlopen(DATA_NAMESPACE + 'feed.json')
    feed = json.load(f)
    f.close()

    # also cache rss.py
    hit_url(DATA_NAMESPACE + 'rss.py')

    for bin_pid in [bin['pid'] for bin in feed[:mosaics]]:
        hit_url(bin_pid + '/head.json');
        hit_url(bin_pid + '/short.json');

    for bin_pid in [bin['pid'] for bin in feed[:mosaics]]:
        for size in ['small', 'medium']:
            hit_url(bin_pid + '/mosaic/'+size+'.json');
            hit_url(bin_pid + '/mosaic/'+size+'.jpg');

    for bin_pid in [bin['pid'] for bin in feed[:bins]]:
        f = urlopen(bin_pid + '/mosaic/small.json')
        mosaic = json.load(f)
        f.close()

        for tile in mosaic['tiles']:
            pid = tile['pid'] # target pid
            hit_url(pid + '.jpg')
            hit_url(pid + '.png')
            hit_url(pid + '/head.json')

if __name__=='__main__':
    spider()
