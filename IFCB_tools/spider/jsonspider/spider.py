#!/usr/bin/python

from gearman.worker import GearmanWorker
from gearman.client import GearmanClient
from os import path, mkdir
import re
from urllib2 import urlopen, URLError

CACHE = './cache'

def path_split(p):
    "Recursively split a path into its components"
    (rest,last) = path.split(p)
    if rest == '/' or rest == '.':
        return [last]
    else:
        return path_split(rest) + [last]

def mkdirs(p):
    "Ensure a pathname's enclosing directory exists"
    pc = path_split(p)
    for n in range(1,len(pc)):
        dir = apply(path.join,pc[:n])
        if not(path.exists(dir)):
            mkdir(dir)
            
def url2cache(url):
    "For a given URL, generate its location in the web cache directory"
    p = path.join(CACHE,re.sub(r'^https?://','',url))
    return p

def url2hrefs(url):
    "Extract all URL's from the content of a specific URL. Also cache the web data"
    file = url2cache(url)
    if path.exists(file): # already fetched?
        return # skip
    try:
        f = urlopen(url)
    except URLError:
        return
    s = f.read()
    # cache
    mkdirs(file)
    with open(file,'wb') as o:
        o.write(s)
    # very crude parsing just splits on occurrences of http://
    for chunk in re.split('http://',s)[1:]:
        href = 'http://' + re.sub(r'([^"}< ]+).*',r'\1',chunk,re.M)
        yield href

def spider(worker, job):
    "Gearman entry point"
    url = job.data
    client = GearmanClient(['localhost'])
    for href in url2hrefs(url): # for URL the content of that URL refers to,
        (blah,ext) = path.splitext(href)
        if ext != '.json':
            href = href + '.json'
        # submit a new spider job for that href
        client.submit_job('spider',href,background=True,wait_until_complete=False)
    return job.data

# start the worker
worker = GearmanWorker(['localhost'])

# register the entry point
worker.register_task('spider',spider)

# go
worker.work()
