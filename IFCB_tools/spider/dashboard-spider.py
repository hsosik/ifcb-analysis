#!/usr/bin/python
from urllib2 import urlopen
import json
import re
import os
from shutil import copyfileobj

cache = './cache'

def lid(pid):
    return re.sub('http://[^/]+/','',pid)

def cacheurl(url):
    print 'caching ' + url + '...'
    fn = lid(url)
    u = urlopen(url)
    f = open(os.path.join(cache,fn),'wb')
    copyfileobj(u,f)
    u.close()
    f.close()


cacheurl('http://ifcb-data.whoi.edu/feed.json')

f = urlopen('http://ifcb-data.whoi.edu/feed.json')
feed = json.load(f)
f.close()

for bin_pid in [bin['pid'] for bin in feed]:
    l = lid(bin_pid)

    try:
        os.mkdir(os.path.join(cache,l))
        os.mkdir(os.path.join(cache,l,'mosaic'))
    except:
        pass

    cacheurl(bin_pid + '/head.json');
    cacheurl(bin_pid + '/short.json');

    for size in ['small', 'medium']:
        cacheurl(bin_pid + '/mosaic/'+size+'.json');
        cacheurl(bin_pid + '/mosaic/'+size+'.jpg');

for bin_pid in [bin['pid'] for bin in feed]:
    f = urlopen(bin_pid + '/mosaic/small.json')
    mosaic = json.load(f)
    f.close()

    for tile in mosaic['tiles']:
        pid = tile['pid'] # target pid
        try:
            os.mkdir(os.path.join(cache,lid(pid)))
        except:
            pass
        cacheurl(pid + '.jpg')
        cacheurl(pid + '/head.json')

