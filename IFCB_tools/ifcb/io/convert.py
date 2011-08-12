import ifcb
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys

# turn a bin of target's into an xml representation
def bin2xml(bin,out=sys.stdout):
    dc = 'http://purl.org/dc/elements/1.1/'
    # ifcb namespace is the default
    nsmap = { None: ifcb.namespace, 'dc': dc }
    # top level is called "bin"
    root = Element(QName(ifcb.namespace, 'Bin'), nsmap=nsmap)
    SubElement(root,QName(dc,'identifier')).text = bin.pid()
    SubElement(root,QName(dc,'date')).text = bin.iso8601time()
    headers = bin.headers()
    for c in headers[CONTEXT]:
        SubElement(root,QName(ifcb.namespace,CONTEXT)).text = str(c)
    for name in [name for name,cast in HDR_SCHEMA if headers.has_key(name)]:
        SubElement(root,QName(ifcb.namespace,name)).text = str(headers[name])
    target_number = 1
    for target_info in bin.all_targets():
        target = SubElement(root,QName(ifcb.namespace, 'Target'), number=str(target_number))
        target_number = target_number + 1
        SubElement(target,QName(dc,'identifier')).text = target_info[PID]
        # each target is a dict. prepend the ifcb namespace to each dict key and make subtags
        for tag in [column for column,type in ADC_SCHEMA]:
            if tag != PID:
                property = SubElement(target,QName(ifcb.namespace,tag))
                property.text = str(target_info[tag])
    return ElementTree(root).write(out, pretty_print=True)

