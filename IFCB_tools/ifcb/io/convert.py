import ifcb
from ifcb import lid
import io
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT, TARGET_NUMBER, FRAME_GRAB_TIME, HEIGHT, WIDTH, DETAIL_FULL, DETAIL_SHORT, DETAIL_HEAD
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys
import simplejson
import string
from ifcb.util import order_keys, decamel
from array import array
import pylibmc
from cache import cache_io
import shutil
import config
import tempfile

"""Conversions between IFCB data and standard formats"""

DUBLIN_CORE_NAMESPACE = 'http://purl.org/dc/elements/1.1/'
DC_TERMS_NAMESPACE = 'http://purl.org/dc/terms/'
RDF_NAMESPACE = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'

def ifcb_term(local_id):
    return QName(ifcb.TERM_NAMESPACE, local_id)

def dc_term(local_id):
    return QName(DUBLIN_CORE_NAMESPACE, local_id)

def rdf_term(local_id):
    return QName(RDF_NAMESPACE, local_id)

DC_IDENTIFIER = dc_term('identifier')
DC_DATE = dc_term('date')

DC_TERMS_HAS_FORMAT = QName(DC_TERMS_NAMESPACE, 'hasFormat')

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

XML_NSMAP = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE,
              'dcterms' : DC_TERMS_NAMESPACE }

RDF_NSMAP = { None: ifcb.TERM_NAMESPACE,
             'dc': DUBLIN_CORE_NAMESPACE,
             'rdf': RDF_NAMESPACE,
             'dcterms' : DC_TERMS_NAMESPACE }

def Sub(parent, name, clazz, text=None):
    child = SubElement(parent, name)
    child.set('class',clazz)
    if text is not None:
        child.text = str(text)
    return child

def __rdf():
    return Element(RDF_RDF, nsmap=RDF_NSMAP)

def day2rdf(day,out=sys.stdout):
    rdf = __rdf()
    root = SubElement(rdf, IFCB_DAY)
    root.set(RDF_ABOUT, day.pid())
    SubElement(root, DC_DATE).text = day.iso8601time()
    SubElement(root, DC_TERMS_HAS_FORMAT).text = day.pid() + '.xml'
    SubElement(root, DC_TERMS_HAS_FORMAT).text = day.pid() + '.json'
    bins = SubElement(root, IFCB_HAS_BINS)
    seq = SubElement(bins, RDF_SEQ)
    seq.set(RDF_ABOUT, day.pid()+'/bins')
    for bin in day:
        li = SubElement(seq, RDF_LI)
        elt = SubElement(li, IFCB_BIN)
        elt.set(RDF_ABOUT, bin.pid())
    return ElementTree(rdf).write(out, pretty_print=True)

def day2xml(day,out=sys.stdout):
    root = Element(IFCB_DAY, nsmap=XML_NSMAP)
    SubElement(root, DC_DATE).text = day.iso8601time()
    for bin in day:
        elt = SubElement(root, IFCB_BIN)
        elt.set(DC_IDENTIFIER, bin.pid())
    return ElementTree(root).write(out, pretty_print=True)

def __html(title,heading=True):
    html = Element('html')
    head = SubElement(html, 'head')
    SubElement(head, 'title').text = title
    SubElement(head, 'link', type='text/css', href='ifcb.css', rel='Stylesheet')
    body = SubElement(html, 'body')
    if heading:
        Sub(body, 'div', 'title').text = title
    return (html, body)

def bin_title(bin):
    return 'Sample @ ' + bin.iso8601time()

def target_title(target):
    return 'Target #%d @ %fs' % (target.info[TARGET_NUMBER], target.info[FRAME_GRAB_TIME])

def href(pid,extension='html'):
    return ''.join([config.URL_BASE, pid, '.', extension])

def __bins2html(parent,bins):
    div = Sub(parent, 'div', 'bins')
    ul = Sub(div, 'ul', 'bins')
    for bin in bins:
        li = Sub(ul, 'li', 'bin')
        SubElement(li, 'a', href=href(bin.pid())).text = bin_title(bin)
        
def day2html(day,out=sys.stdout):
    (html, body) = __html(day.iso8601time())
    __bins2html(body,day)
    return ElementTree(html).write(out, pretty_print=True)

def day2json(day,out=sys.stdout):
    j = { 'date': day.iso8601time() }
    j['bins'] = [bin.pid() for bin in day]
    return simplejson.dump(j,out)

# raw data

def __copy_file(path,out):
    f = open(path,'rb')
    shutil.copyfileobj(f, out)
    f.close()
    
def bin2hdr(bin,out=sys.stdout,detail=DETAIL_HEAD):
    __copy_file(bin.hdr_path(),out)
    
def bin2adc(bin,out=sys.stdout,detail=DETAIL_FULL):
    __copy_file(bin.adc_path(),out)
    
def bin2roi(bin,out=sys.stdout,detail=DETAIL_FULL):
    __copy_file(bin.roi_path(),out)
    
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
    for tag in order_keys(target.info, [column for column,type in ADC_SCHEMA]):
         if tag != PID:
            property = SubElement(elt, ifcb_term(tag))
            property.text = str(target.info[tag])

def __target2xml(target, root=None):
    elt = None
    if root is not None:
        elt = SubElement(root, IFCB_TARGET, number=str(target.info[TARGET_NUMBER]))
    else:
        elt = Element(IFCB_TARGET, nsmap=XML_NSMAP, number=str(target.info[TARGET_NUMBER]))
    pid = target.info[PID]
    SubElement(elt, DC_IDENTIFIER).text = target.info[PID]
    __target_properties(target, elt)
    SubElement(elt, DC_TERMS_HAS_FORMAT).text = target.info[PID] + '.png'
    return elt

def target2xml(target,out=sys.stdout):
    ElementTree(__target2xml(target)).write(out, pretty_print=True)
       
# turn a bin of targets into an xml representation; outputs to given output stream
def bin2xml(bin,out=sys.stdout,detail=DETAIL_SHORT):
    # top level is called "bin"
    root = Element(IFCB_BIN, nsmap=XML_NSMAP)
    pid = bin.pid()
    SubElement(root, DC_IDENTIFIER).text = pid
    __add_headers(bin,root)
    if detail != DETAIL_HEAD:
        target_number = 1
        for target in bin:
            if detail == DETAIL_FULL:
                __target2xml(target, root)
            else:
                elt = SubElement(root, IFCB_TARGET)
                elt.set(DC_IDENTIFIER, target.pid())
    return ElementTree(root).write(out, pretty_print=True)

ATOM_NAMESPACE = 'http://www.w3.org/2005/Atom'
XHTML_NAMESPACE = 'http://www.w3.org/1999/xhtml'

def __feed_bins(fs,n=20,date=None):
    if date is None:
        return list(reversed(fs.latest_bins(n)))
    else:
        return reversed(list(fs.all_bins(date)))
    
def fs2atom(fs,link,n=20,date=None,out=sys.stdout):
    nsmap = { None: ATOM_NAMESPACE }
    xhtml = { None: 'http://www.w3.org/1999/xhtml' }
    bins = __feed_bins(fs,n,date)
    feed = Element('feed', nsmap=nsmap)
    SubElement(feed, 'title').text = 'Imaging FlowCytobot most recent data'
    SubElement(feed, 'subtitle').text = 'Live marine phytoplankton cytometry with imagery'
    author = SubElement(feed, 'author')
    SubElement(author, 'name').text = 'Imaging FlowCytobot'
    SubElement(feed, 'link', href=link, rel='self')
    SubElement(feed, 'id').text = link
    SubElement(feed, 'updated').text = bins[0].iso8601time()
    for bin in bins:
        t = SubElement(feed, 'entry')
        SubElement(t, 'title').text = bin_title(bin)
        SubElement(t, 'link', href=bin.pid(), rel='alternate', type='application/rdf+xml')
        SubElement(t, 'link', href=bin.pid()+'.xml', rel='alternate', type='text/xml')
        SubElement(t, 'link', href=bin.pid()+'.json', rel='alternate', type='application/json')
        SubElement(t, 'id').text = bin.pid()
        SubElement(t, 'updated').text = bin.iso8601time()
        content = SubElement(t, 'content', type='xhtml')
        div = SubElement(content, QName(XHTML_NAMESPACE, 'div'), nsmap=xhtml)
        headers = bin.headers()
        for header in sorted(headers.keys()):
            SubElement(div, 'div').text = header + ': ' + str(headers[header])
    ElementTree(feed).write(out, pretty_print=True)

def fs2rss(fs,link,n=20,date=None,out=sys.stdout):
    xhtml = { None: 'http://www.w3.org/1999/xhtml' }
    bins = __feed_bins(fs,n,date)
    rss = Element('rss')
    feed = SubElement(rss, 'feed')
    SubElement(feed, 'title').text = 'Imaging FlowCytobot most recent data'
    SubElement(feed, 'description').text = 'Live marine phytoplankton cytometry with imagery'
    SubElement(feed, 'author').text = 'Imaging FlowCytobot'
    SubElement(feed, 'link').text = link
    SubElement(feed, 'pubDate').text = bins[0].rfc822time()
    SubElement(feed, 'ttl').text = '20'
    for bin in bins:
        t = SubElement(feed, 'entry')
        SubElement(t, 'title').text = bin_title(bin)
        SubElement(t, 'guid').text = bin.pid()
        SubElement(t, 'link').text = bin.pid() + '.html'
        SubElement(t, 'pubDate').text = bin.rfc822time()
        content = SubElement(t, 'description')
        headers = bin.headers()
        body = '\n'.join(['<div>%s: %s</div>' % (header, headers[header]) for header in sorted(headers.keys())])
        content.text = '<div>%s</div>' % body
    ElementTree(rss).write(out, pretty_print=True)

def fs2html_feed(fs,link,n=20,date=None,out=sys.stdout):
    bins = __feed_bins(fs,n,date)
    (html, body) = __html('Imaging FlowCytobot most recent data')
    __bins2html(body, bins)
    ElementTree(html).write(out, pretty_print=True)
    
def fs2json_feed(fs,link,n=20,date=None,out=sys.stdout):
    simplejson.dump([bin.properties(True) for bin in __feed_bins(fs,n,date)],out)

def pretty_property_name(propName):
    return decamel(propName)

def bin2html(bin,out=sys.stdout,detail=DETAIL_SHORT):
    (html, body) = __html(bin_title(bin))
    properties = Sub(body, 'div', 'properties')
    for k in order_keys(bin.properties(), [column for column,type in HDR_SCHEMA]):
        prop = Sub(properties, 'div', 'property')
        Sub(prop, 'div', 'label').text = pretty_property_name(k)
        Sub(prop, 'div', 'value').text = str(bin.properties()[k])
    if detail != DETAIL_HEAD:
        targets = Sub(body, 'div', 'targets')
        ul = Sub(targets,'ul','targets')
        for target in bin:
            li = Sub(ul, 'li', 'target')
            a = SubElement(li, 'a', href=href(target.pid()))
            a.text = target_title(target)
            a.tail = ' %dB' % (target.info[HEIGHT] * target.info[WIDTH])
    ElementTree(html).write(out, pretty_print=True)

def target2html(target,out=sys.stdout):
    (html, body) = __html(target_title(target))
    properties = Sub(body, 'div', 'properties')
    parent_link = Sub(properties, 'div', 'property')
    Sub(parent_link, 'div', 'label').text = 'bin'
    link = Sub(parent_link, 'div', 'bin value')
    SubElement(link, 'a', href=href(target.bin.pid())).text = bin_title(target.bin)
    for k in order_keys(target.info, [column for column,type in ADC_SCHEMA]):
        prop = Sub(properties, 'div', 'property')
        Sub(prop, 'div', 'label').text = pretty_property_name(k)
        Sub(prop, 'div', 'value').text = str(target.info[k])
    id = Sub(body, 'div', 'image')
    img = SubElement(id, 'img', src=href(target.pid(),'png'))
    img.set('class','image')
    ElementTree(html).write(out, pretty_print=True)
        
def __target2rdf(target,parent):
    elt = SubElement(parent, IFCB_TARGET)
    elt.set(RDF_ABOUT, target.info[PID])
    __target_properties(target, elt)
    SubElement(elt, DC_TERMS_HAS_FORMAT).text = target.pid() + '.png'

def target2rdf(target,out=sys.stdout):
    rdf = __rdf()
    __target2rdf(target,rdf)
    return ElementTree(rdf).write(out, pretty_print=True)
    
def bin2rdf(bin,out=sys.stdout,detail=DETAIL_SHORT):
    rdf = __rdf()
    root = SubElement(rdf, IFCB_BIN)
    pid = bin.pid()
    root.set(RDF_ABOUT, pid)
    __add_headers(bin,root)
    SubElement(root, DC_TERMS_HAS_FORMAT).text = bin.pid() + '.xml'
    SubElement(root, DC_TERMS_HAS_FORMAT).text = bin.pid() + '.json'
    if detail != DETAIL_HEAD:
        targets = SubElement(root, IFCB_HAS_TARGETS)
        targets.set(RDF_ABOUT, pid + '/targets')
        seq = SubElement(targets, RDF_SEQ)
        for target in bin:
            li = SubElement(seq, RDF_LI)
            if detail == DETAIL_FULL:
                __target2rdf(target,li)
            else:
                t = SubElement(li, IFCB_TARGET)
                t.set(RDF_ABOUT, target.pid())
    return ElementTree(rdf).write(out, pretty_print=True)

def bin_as_json(bin,detail=DETAIL_SHORT):
    result = bin.properties()
    if detail == DETAIL_FULL:
        result['targets'] = [target.info for target in bin];
    elif detail != DETAIL_HEAD:
        result['targets'] = [target.pid() for target in bin];
    return result

# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout,detail=DETAIL_FULL):
    result = bin_as_json(bin,detail)
    return simplejson.dump(result,out)

def target2json(target,out=sys.stdout):
    return simplejson.dump(target.info,out)

def target2image(target,format='PNG',out=sys.stdout):
    format = string.upper(format)
    cache_key = lid(target.pid()) + '.' + string.lower(format)
    cache_io(cache_key, lambda o: target.image().save(o,format), out)
    
def target2png(target,out=sys.stdout):
    target2image(target,'PNG',out)

def target2jpg(target,out=sys.stdout):
    target.image().save(out,'JPEG')

def target2bmp(target,out=sys.stdout):
    target.image().save(out,'BMP')

def target2gif(target,out=sys.stdout):
    target.image().save(out,'GIF')
    
def target2tiff(target,out=sys.stdout):
    with tempfile.SpooledTemporaryFile() as flo:
        target.image().save(flo,'TIFF')
        flo.seek(0)
        shutil.copyfileobj(flo, out)
