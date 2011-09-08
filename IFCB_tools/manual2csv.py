#!/usr/bin/python
from scipy.io import loadmat
import numpy
from numpy import squeeze
from os import path
import math
import sys

def sq(thang):
    return map(squeeze, thang)

def intNan(f):
    if math.isnan(f):
        return None
    else:
        return int(f)
    
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

def manual2csv(path):
    l = loadmat(path)
    annotations = sq(l['classlist'])
    base_classes = [None] + sq(l['class2use_manual'][0])
    sub_classes = [None] + sq(l['class2use_sub4'][0])

    print 'roi_number,manual,SVM-auto,ciliate'    
    for annotation in annotations:
        (roi, manual, svm_auto, ciliate) = map(intNan, annotation)
        print '%d,%s,%s,%s' % (roi, base_classes[manual] if manual is not None else '', base_classes[svm_auto] if svm_auto is not None else '', sub_classes[ciliate] if ciliate is not None else '')
    
#dump_mat_field('manual_list.mat','manual_list')
#dump_mat_field('IFCB1_2006_158_000036.mat','classlist')
#manual2csv('../exampleData/annotation/IFCB1_2006_158_000036.mat')

if __name__=='__main__':
    manual2csv(sys.argv[1])

