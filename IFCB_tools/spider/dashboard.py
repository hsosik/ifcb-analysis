#!/usr/bin/python
from urllib2 import urlopen
import json
import re
import os
from shutil import copyfileobj

def lid(pid):
    return re.sub('http://[^/]+/','',pid)

def hit_url(url):
    print 'hitting ' + url + '...'
    u = urlopen(url)
    while True:
        b = u.read(2**20)
        if not b:
            return

def spider():
    f = urlopen('http://ifcb-data.whoi.edu/feed.json')
    feed = json.load(f)
    f.close()

    for bin_pid in [bin['pid'] for bin in feed[:7]]:
        hit_url(bin_pid + '/head.json');
        hit_url(bin_pid + '/short.json');

    for size in ['small', 'medium']:
        for bin_pid in [bin['pid'] for bin in feed[:7]]:
            hit_url(bin_pid + '/mosaic/'+size+'.json');
            hit_url(bin_pid + '/mosaic/'+size+'.jpg');

    for bin_pid in [bin['pid'] for bin in feed[:1]]:
        f = urlopen(bin_pid + '/mosaic/small.json')
        mosaic = json.load(f)
        f.close()

        for tile in mosaic['tiles']:
            pid = tile['pid'] # target pid
            hit_url(pid + '.jpg')
            hit_url(pid + '/head.json')

if __name__=='__main__':
    spider()
