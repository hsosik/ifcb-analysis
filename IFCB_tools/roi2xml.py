#!/usr/bin/python
import re
from sys import argv, stdout
import ifcb
from ifcb.io import Bin
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement

def rois2xml(bin,out):
    nsmap = {None: ifcb.namespace}
    root = Element(QName(ifcb.namespace, 'bin'), nsmap=nsmap)
    for roi_info in bin.all_rois():
        roi = SubElement(root,QName(ifcb.namespace, 'roi'))
        for tag, value in roi_info.items():
            property = SubElement(roi,QName(ifcb.namespace,tag))
            property.text = str(value)
    return ElementTree(root).write(out, pretty_print=True)

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2xml [id] [dir: .]'
    else:
        # allow id to be the ROI file name, strip off the .roi extension if it's there
        id = re.sub('(.*)\\.[a-z]+','\\1',argv[1])
        dir = '.'
        arg = 2
        if(len(argv) > arg):
            dir = argv[arg]
            arg = arg + 1
        rois2xml(Bin(id,dir),stdout)
        