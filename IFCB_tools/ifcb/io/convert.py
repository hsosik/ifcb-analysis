import ifcb
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys
import simplejson

DUBLIN_CORE_NAMESPACE = 'http://purl.org/dc/elements/1.1/'

def ifcb_term(local_id):
    return QName(ifcb.TERM_NAMESPACE, local_id)

def dc_term(local_id):
    return QName(DUBLIN_CORE_NAMESPACE, local_id)

# turn a bin of targets into an xml representation; outputs to given output stream
def bin2xml(bin,out=sys.stdout):
    
    # ifcb namespace is the default
    nsmap = { None: ifcb.TERM_NAMESPACE, 'dc': DUBLIN_CORE_NAMESPACE }
    # top level is called "bin"
    root = Element(ifcb_term('Bin'), nsmap=nsmap)
    SubElement(root, dc_term('identifier')).text = bin.pid()
    SubElement(root, dc_term('date')).text = bin.iso8601time()
    headers = bin.headers()
    for c in headers[CONTEXT]:
        SubElement(root,ifcb_term(CONTEXT)).text = str(c)
    for name in [name for name,cast in HDR_SCHEMA if headers.has_key(name)]:
        SubElement(root,ifcb_term(name)).text = str(headers[name])
    target_number = 1
    for target_info in bin.all_targets():
        target = SubElement(root, ifcb_term('Target'), number=str(target_number))
        target_number = target_number + 1
        SubElement(target, dc_term('identifier')).text = target_info[PID]
        # each target is a dict. prepend the ifcb namespace to each dict key and make subtags
        for tag in [column for column,type in ADC_SCHEMA]:
            if tag != PID:
                property = SubElement(target, ifcb_term(tag))
                property.text = str(target_info[tag])
    return ElementTree(root).write(out, pretty_print=True)

# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout):
    result = bin.headers()
    result['targets'] = list(bin.all_targets())
    return simplejson.dump(result,out)
