#!/usr/bin/python
from scipy.io import loadmat
from numpy import squeeze

l = loadmat('../exampleData/annotation/IFCB1_2006_158_000036.mat')
x = [squeeze(x) for x in l['classlist'].tolist()]
y = [squeeze(x) for x in l['class2use_manual'][0].tolist()]

print l

i = 1
for a in y:
    print '%d. %s' % (i,a)
    i = i + 1
