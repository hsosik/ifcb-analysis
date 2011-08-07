#!/usr/bin/python
import re
from sys import argv, stdout
import ifcb
from ifcb.io import Bin, PID
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement

dc = 'http://purl.org/dc/elements/1.1/'

# turn a bin of roi's into an xml representation
def rois2xml(bin,out):
    # ifcb namespace is the default
    nsmap = {None: ifcb.namespace, 'dc': dc}
    # top level is called "bin"
    root = Element(QName(ifcb.namespace, 'bin'), nsmap=nsmap)
    SubElement(root,QName(dc,'identifier')).text = bin.pid()
    for roi_info in bin.all_rois():
        roi = SubElement(root,QName(ifcb.namespace, 'roi'))
        SubElement(roi,QName(dc,'identifier')).text = roi_info[PID]
        # each roi is a dict. prepend the ifcb namespace to each dict key and make subtags
        for tag, value in roi_info.items():
            if tag != PID:
                property = SubElement(roi,QName(ifcb.namespace,tag))
                property.text = str(value)
    return ElementTree(root).write(out, pretty_print=True)

if __name__ == '__main__':
    if(len(argv) < 2):
        print 'usage: roi2xml [id] [dir: .]'
    else:
        rois2xml(Bin(*argv[1:]),stdout)
        