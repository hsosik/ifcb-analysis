#!/usr/bin/python
from scipy.io import loadmat
import numpy
from numpy import squeeze
from os import path

def ensqueezinate(thang):
    return [squeeze(t) for t in thang.tolist()]

def csvrep(x):
    if numpy.isnan(x):
        return '""'
    elif x.dtype.kind == 'U':
        return '"%s"' % x
    else:
        return '%s' % x

def dump_mat_field(file,field):
    l = loadmat(path.join('../exampleData/annotation/',file))

    for row in l[field]:
        print ','.join([csvrep(squeeze(c)) for c in row])
    
def dumpanno():
    l = loadmat('../exampleData/annotation/IFCB1_2006_158_000036.mat')
    x = [squeeze(x) for x in l['classlist'].tolist()]
    y = [squeeze(x) for x in l['class2use_manual'][0].tolist()]

    print l

    i = 1
    for a in y:
        print '%d. %s' % (i,a)
        i = i + 1
    
#dump_mat_field('manual_list.mat','manual_list')
#dump_mat_field('IFCB1_2006_158_000036.mat','classlist')
dumpanno()
