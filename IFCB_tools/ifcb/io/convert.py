import ifcb
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys
import simplejson

DUBLIN_CORE_NAMESPACE = 'http://purl.org/dc/elements/1.1/'
RDF_NAMESPACE = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'

def ifcb_term(local_id):
    return QName(ifcb.TERM_NAMESPACE, local_id)

def dc_term(local_id):
    return QName(DUBLIN_CORE_NAMESPACE, local_id)

def rdf_term(local_id):
    return QName(RDF_NAMESPACE, local_id)

DC_IDENTIFIER = dc_term('identifier')
DC_DATE = dc_term('date')

IFCB_BIN = ifcb_term('Bin')
IFCB_TARGET = ifcb_term('Target')
IFCB_CONTEXT = ifcb_term(CONTEXT)
IFCB_HAS_TARGETS = ifcb_term('hasTargets')

RDF_RDF = rdf_term('RDF')
RDF_SEQ = rdf_term('Seq')
RDF_ABOUT = rdf_term('about')
RDF_LI = rdf_term('li')

# some shared code for XML and RDF representations
def __add_headers(bin,root):
    SubElement(root, DC_DATE).text = bin.iso8601time()    
    headers = bin.headers()
    for c in headers[CONTEXT]:
        SubElement(root,IFCB_CONTEXT).text = str(c)
    for name in [name for name,cast in HDR_SCHEMA if headers.has_key(name)]:
        SubElement(root,ifcb_term(name)).text = str(headers[name])

def __target_properties(target_info, target):
    # each target is a dict. prepend the ifcb namespace to each dict key and make subtags
    for tag in [column for column,type in ADC_SCHEMA]:
         if tag != PID:
            property = SubElement(target, ifcb_term(tag))
            property.text = str(target_info[tag])
    
# turn a bin of targets into an xml representation; outputs to given output stream
def bin2xml(bin,out=sys.stdout):
    # ifcb namespace is the default
    nsmap = { None: ifcb.TERM_NAMESPACE, 'dc': DUBLIN_CORE_NAMESPACE }
    # top level is called "bin"
    root = Element(IFCB_BIN, nsmap=nsmap)
    SubElement(root, DC_IDENTIFIER).text = bin.pid()
    __add_headers(bin,root)
    target_number = 1
    for target_info in bin.all_targets():
        target = SubElement(root, IFCB_TARGET, number=str(target_number))
        target_number = target_number + 1
        SubElement(target, DC_IDENTIFIER).text = target_info[PID]
        __target_properties(target_info, target)
    return ElementTree(root).write(out, pretty_print=True)

def __rdf():
    nsmap = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE,
             'rdf': RDF_NAMESPACE }
    return Element(RDF_RDF, nsmap=nsmap)
    
def __target2rdf(target_info,parent):
    target = SubElement(parent, IFCB_TARGET)
    target.set(RDF_ABOUT, target_info[PID])
    __target_properties(target_info, target)

def target2rdf(target_info,out=sys.stdout):
    rdf = __rdf()
    __target2rdf(target_info,rdf)
    return ElementTree(root).write(out, pretty_print=True)
    
def bin2rdf(bin,out=sys.stdout):
    rdf = __rdf()
    root = SubElement(rdf, IFCB_BIN)
    root.set(RDF_ABOUT, bin.pid())
    __add_headers(bin,root)
    targets = SubElement(root, IFCB_HAS_TARGETS)
    targets.set(RDF_ABOUT, bin.pid() + '/targets')
    seq = SubElement(targets, RDF_SEQ)
    for target_info in bin.all_targets():
        li = SubElement(seq, RDF_LI)
        __target2rdf(target_info, li)
    return ElementTree(rdf).write(out, pretty_print=True)
    
# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout):
    result = bin.headers()
    result['targets'] = list(bin)
    return simplejson.dump(result,out)
