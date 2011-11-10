#!/usr/bin/python
import psycopg2 as pg
from scipy.io import loadmat
import numpy
from numpy import squeeze, isnan
from os import path
import os
import math
import sys
import re

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

def manual2tuples(path):
    lid = re.sub('.*/(.*).mat','\\1',path)
    l = loadmat(path)
    try:
        cols = map(str,sq(l['list_titles'][0]))
        annotations = sq(l['classlist'])
        manual_classes = [None] + sq(l['class2use_manual'][0])
        auto_classes = [None] + sq(l['class2use_auto'][0])
        sub_classes = {}
        for n,sub_col in zip(range(4,len(cols)+1),cols[3:]):
            field = 'class2use_sub%d' % n
            if field in l:
                sub_classes[sub_col] = sq(l[field][0])

        for annotation in annotations:
            (roi, manual, svm_auto) = map(intNan, annotation[:3])
            subs = {}
            for n,sub in zip(range(3,len(annotation)),annotation[3:]):
                if not isnan(sub):
                    col = cols[n]
                    subs[cols[n]] = str(sub_classes[cols[n]][int(sub)-1])
            yield (lid, '%s_%05d' % (lid, roi), str(manual_classes[manual-1]) if manual is not None else None, str(auto_classes[svm_auto-1]) if svm_auto is not None else None, subs)
    except:
        if not 'class2use_sub4' in l:
            print 'missing class2use_sub4 on %s' % lid
        else:
            print l
            print l.keys()
            print cols
            print n 
            print annotation
            print sub
            print sub_classes
            raise
    
#dump_mat_field('manual_list.mat','manual_list')
#dump_mat_field('IFCB1_2006_158_000036.mat','classlist')
#manual2csv('../exampleData/annotation/IFCB1_2006_158_000036.mat')

def sqlize_str(value):
    if value is None:
        return None
    else:
        return str(value)
    
if __name__=='__main__':
    PSQL_DB = 'ifcb'
    PSQL_USER = 'jfutrelle'
    PSQL_PASSWORD = 'vNLH814i'

    conn = pg.connect('dbname=%s user=%s password=%s' % (PSQL_DB,PSQL_USER,PSQL_PASSWORD))

    db = conn.cursor()
    
    #manual2csv(sys.argv[1])
    #manual2csv('../exampleData/annotation/IFCB1_2006_158_000036.mat')
    dir = '/Users/jfutrelle/dev/ifcb/manual'
    for f in os.listdir(dir):
        if re.match('IFCB._[\d_]+\\.mat',f):
            bin_lid = re.sub('\\.mat','',f)
            db.execute("select count(*) from manual where bin_lid = %s",(bin_lid,))
            count = db.fetchone()[0]
            if count > 0:
                #print 'skipping %s...' % f
                pass
            else:
                p = os.path.join(dir,f)
                print 'processing %s...' % f
                try:
                    for (bin_lid, roi_lid, manual, svm_auto, subs) in manual2tuples(p):
                        if manual is not None: # for now, just ones with manual class
                            (bin_lid, roi_lid, manual, svm_auto) = map(sqlize_str,(bin_lid, roi_lid, manual, svm_auto))
                            db.execute("INSERT INTO manual (bin_lid, roi_lid, manual, svm_auto) VALUES (%s,%s,%s,%s)",(bin_lid,roi_lid,manual,svm_auto))
                            for key,value in subs.items():
                                db.execute("INSERT INTO manual_sub (bin_lid, roi_lid, sub_column, sub_class) VALUES (%s,%s,%s,%s)",(bin_lid,roi_lid,key,value))
                    conn.commit()
                except:
                    #raise
                    pass

