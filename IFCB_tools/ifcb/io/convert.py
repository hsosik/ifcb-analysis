import ifcb
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT, TARGET_NUMBER
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys
import simplejson
import string

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

IFCB_DAY = ifcb_term('Day')
IFCB_BINS = ifcb_term('bins')
IFCB_BIN = ifcb_term('Bin')
IFCB_TARGET = ifcb_term('Target')
IFCB_TARGETS = ifcb_term('targets')
IFCB_CONTEXT = ifcb_term(CONTEXT)
IFCB_HAS_TARGETS = ifcb_term('hasTargets')
IFCB_HAS_BINS = ifcb_term('hasBins')

RDF_RDF = rdf_term('RDF')
RDF_SEQ = rdf_term('Seq')
RDF_ABOUT = rdf_term('about')
RDF_LI = rdf_term('li')

# TODO generate links to images

def __rdf():
    nsmap = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE,
             'rdf': RDF_NAMESPACE }
    return Element(RDF_RDF, nsmap=nsmap)

def day2rdf(day,out=sys.stdout):
    rdf = __rdf()
    root = SubElement(rdf, IFCB_DAY)
    root.set(RDF_ABOUT, day.pid())
    SubElement(root, DC_DATE).text = day.iso8601time()
    bins = SubElement(root, IFCB_HAS_BINS)
    seq = SubElement(bins, RDF_SEQ)
    seq.set(RDF_ABOUT, day.pid()+'/bins')
    for bin in day:
        li = SubElement(seq, RDF_LI)
        elt = SubElement(li, IFCB_BIN)
        elt.set(RDF_ABOUT, bin.pid())
    return ElementTree(rdf).write(out, pretty_print=True)

def day2xml(day,out=sys.stdout):
    nsmap = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE }
    root = Element(IFCB_DAY, nsmap=nsmap)
    SubElement(root, DC_DATE).text = day.iso8601time()
    for bin in day:
        elt = SubElement(root, IFCB_BIN)
        elt.set(DC_IDENTIFIER, bin.pid())
    return ElementTree(root).write(out, pretty_print=True)

def day2json(day,out=sys.stdout):
    j = { 'date': day.iso8601time() }
    j['bins'] = [bin.pid() for bin in day]
    return simplejson.dump(j,out)
    
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
        elt = SubElement(root, IFCB_TARGET)
        elt.set(DC_IDENTIFIER, target.pid())
    return ElementTree(root).write(out, pretty_print=True)

def __target2rdf(target,parent):
    elt = SubElement(parent, IFCB_TARGET)
    elt.set(RDF_ABOUT, target.info[PID])
    __target_properties(target, elt)

def target2rdf(target,out=sys.stdout):
    rdf = __rdf()
    __target2rdf(target,rdf)
    return ElementTree(rdf).write(out, pretty_print=True)
    
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
        t = SubElement(li, IFCB_TARGET)
        t.set(RDF_ABOUT, target.pid())
    return ElementTree(rdf).write(out, pretty_print=True)
    
# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout):
    result = bin.headers()
    result['targets'] = [target.pid() for target in bin];
    return simplejson.dump(result,out)

def target2json(target,out=sys.stdout):
    return simplejson.dump(target.info,out)

def target2image(target,format='PNG',out=sys.stdout):
    format = string.upper(format)
    target.image().save(out,format)
    
def target2png(target,out=sys.stdout):
    target2image(target,'PNG',out)

def target2jpg(target,out=sys.stdout):
    target2image(target,'JPEG',out)

def target2bmp(target,out=sys.stdout):
    target2image(target,'BMP',out)

def target2gif(target,out=sys.stdout):
    target2image(target,'GIF',out)
    
def target2tiff(target,out=sys.stdout):
    target2image(target,'TIFF',out)

    
    