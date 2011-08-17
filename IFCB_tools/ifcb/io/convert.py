import ifcb
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT, TARGET_NUMBER
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

# TODO generate links to images

# some shared code for XML and RDF representations
def __add_headers(bin,root):
    SubElement(root, DC_DATE).text = bin.iso8601time()    
    headers = bin.headers()
    for c in headers[CONTEXT]:
        SubElement(root,IFCB_CONTEXT).text = str(c)
    for name in [name for name,cast in HDR_SCHEMA if headers.has_key(name)]:
        SubElement(root,ifcb_term(name)).text = str(headers[name])

def __target_properties(target, elt):
    # each target is a dict. prepend the ifcb namespace to each dict key and make subtags
    for tag in [column for column,type in ADC_SCHEMA]:
         if tag != PID:
            property = SubElement(elt, ifcb_term(tag))
            property.text = str(target.info[tag])

def __target2xml(target, root=None):
    elt = None
    if root is not None:
        elt = SubElement(root, IFCB_TARGET, number=str(target.info[TARGET_NUMBER]))
    else:
        nsmap = { None: ifcb.TERM_NAMESPACE, 'dc': DUBLIN_CORE_NAMESPACE }
        elt = Element(IFCB_TARGET, nsmap=nsmap, number=str(target.info[TARGET_NUMBER]))
    SubElement(elt, DC_IDENTIFIER).text = target.info[PID]
    __target_properties(target, elt)
    return elt

def target2xml(target,out=sys.stdout):
    ElementTree(__target2xml(target)).write(out, pretty_print=True)
       
# turn a bin of targets into an xml representation; outputs to given output stream
def bin2xml(bin,out=sys.stdout):
    # ifcb namespace is the default
    nsmap = { None: ifcb.TERM_NAMESPACE, 'dc': DUBLIN_CORE_NAMESPACE }
    # top level is called "bin"
    root = Element(IFCB_BIN, nsmap=nsmap)
    SubElement(root, DC_IDENTIFIER).text = bin.pid()
    __add_headers(bin,root)
    target_number = 1
    for target in bin:
        __target2xml(target, root)
    return ElementTree(root).write(out, pretty_print=True)

def __rdf():
    nsmap = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE,
             'rdf': RDF_NAMESPACE }
    return Element(RDF_RDF, nsmap=nsmap)
    
def __target2rdf(target,parent):
    elt = SubElement(parent, IFCB_TARGET)
    elt.set(RDF_ABOUT, target.info[PID])
    __target_properties(target, elt)

def target2rdf(target,out=sys.stdout):
    rdf = __rdf()
    __target2rdf(target,rdf)
    return ElementTree(root).write(out, pretty_print=True)
    
def bin2rdf(bin,out=sys.stdout):
    rdf = __rdf()
    root = SubElement(rdf, IFCB_BIN)
    root.set(RDF_ABOUT, bin.pid())
    __add_headers(bin,root)
    targets = SubElement(root, IFCB_HAS_TARGETS)
    targets.set(RDF_ABOUT, bin.pid() + '/targets')
    seq = SubElement(targets, RDF_SEQ)
    for target in bin:
        li = SubElement(seq, RDF_LI)
        __target2rdf(target, li)
    return ElementTree(rdf).write(out, pretty_print=True)
    
# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout):
    result = bin.headers()
    result['targets'] = [target.info for target in bin];
    return simplejson.dump(result,out)

def target2json(target,out=sys.stdout):
    return simplejson.dump(target.info,out)