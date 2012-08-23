import ifcb
from ifcb import lid
import io
from ifcb.io import PID, ADC_SCHEMA, HDR_SCHEMA, CONTEXT, TARGET_NUMBER, FRAME_GRAB_TIME, HEIGHT, WIDTH, DETAIL_FULL, DETAIL_SHORT, DETAIL_HEAD
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
import sys
import json
import string
from ifcb.util import order_keys, decamel, iso8601utcnow
from array import array
import pylibmc
from cache import cache_io
import shutil
import config
import tempfile
from PIL import Image
import time
import calendar
from zipfile import ZipFile, ZIP_STORED, ZIP_DEFLATED

"""Conversions between IFCB data and standard formats"""

# XML/RDF namespaces
DUBLIN_CORE_NAMESPACE = 'http://purl.org/dc/elements/1.1/'
DC_TERMS_NAMESPACE = 'http://purl.org/dc/terms/'
RDF_NAMESPACE = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'

def ifcb_term(local_id):
    """Output a term in the IFCB term namespace.
    
    Parameters:
    local_id - the local ID of the term"""
    return QName(ifcb.TERM_NAMESPACE, local_id)

def dc_term(local_id):
    """Output a term in the Dublin Core namespace.
    
    Parameters:
    local_id - the local ID of the term"""
    return QName(DUBLIN_CORE_NAMESPACE, local_id)

def rdf_term(local_id):
    """Output a term in the RDF namespace.
    
    Parameters:
    local_id - the local ID of the term"""
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
RDF_TYPE = rdf_term('type')

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
    """Output RDF representing a day directory.
    
    Parameters:
    day - the day directory (instance of DayDir)
    out - where to write the representation (default: stdout)
    """
    rdf = __rdf()
    # emit
    # <ifcb:Day rdf:about="{day.pid}">
    #   <dc:date>{day.iso8601time}</dc:date>
    #   <dcterms:hasFormat>{day.pid}.xml</dcterms:hasFormat>
    #   <dcterms:hasFormat>{day.pid}.json</dcterms:hasFormat>
    #   ...
    root = SubElement(rdf, IFCB_DAY)
    root.set(RDF_ABOUT, day.pid)
    SubElement(root, DC_DATE).text = day.iso8601time
    SubElement(root, DC_TERMS_HAS_FORMAT).text = day.pid + '.xml'
    SubElement(root, DC_TERMS_HAS_FORMAT).text = day.pid + '.json'
    # emit
    # ...
    #   <ifcb:hasBins>
    #     <rdf:Seq rdf:about="{day.pid}/bins">
    #       <rdf:li rdf:about="{bin.pid}"/>
    #       ...
    bins = SubElement(root, IFCB_HAS_BINS)
    seq = SubElement(bins, RDF_SEQ)
    seq.set(RDF_ABOUT, day.pid+'/bins')
    for bin in day:
        li = SubElement(seq, RDF_LI)
        elt = SubElement(li, IFCB_BIN)
        elt.set(RDF_ABOUT, bin.pid)
    return ElementTree(rdf).write(out, pretty_print=True)

def day2xml(day,out=sys.stdout):
    """Output XML representing a day directory.
    
    Parameters:
    day - the day directory (instance of DayDir)
    out - where to write the representation (default: stdout)
    """
    # emit
    # <ifcb:Day>
    #   <dc:date>{day.iso8601time}</dc:date>
    #   <ifcb:Bin dc:identifier="{bin.pid}"/>
    #   ...
    root = Element(IFCB_DAY, nsmap=XML_NSMAP)
    SubElement(root, DC_DATE).text = day.iso8601time
    for bin in day:
        elt = SubElement(root, IFCB_BIN)
        elt.set(DC_IDENTIFIER, bin.pid)
    return ElementTree(root).write(out, pretty_print=True)

def __html(title,heading=True):
    # emit
    # <html>
    #   <head>
    #     <title>{title}</title>
    #     <link type="text/css" href="ifcb.css" rel="Stylesheet">
    #   </head>
    # <body>
    #   <div class="title">{title}</div>
    #   ...
    html = Element('html')
    head = SubElement(html, 'head')
    SubElement(head, 'title').text = title
    SubElement(head, 'link', type='text/css', href='ifcb.css', rel='Stylesheet')
    body = SubElement(html, 'body')
    if heading:
        Sub(body, 'div', 'title').text = title
    return (html, body)

def bin_title(bin):
    """The title of a Bin instance in text representations"""
    return 'Sample @ ' + bin.iso8601time

def target_title(target):
    """The title of a Target instance in text representations"""
    return 'Target #%d @ %fs' % (target.targetNumber, target.frameGrabTime)

def href(pid,extension='html'):
    """A link to an object of any type given its PID. Uses config.URL_BASE as the base URL.
    
    Parameters:
    pid - the pid of the object
    extension - the extension to add to the end (default: "html")
    """
    return ''.join([config.URL_BASE, pid, '.', extension])

def __bins2html(parent,bins):
    # emit
    # <div class="bins">
    #   <ul class="bins">
    #     <li><a href="{bin.pid}">{bin.title}</li>
    #     ...
    div = Sub(parent, 'div', 'bins')
    ul = Sub(div, 'ul', 'bins')
    for bin in bins:
        li = Sub(ul, 'li', 'bin')
        SubElement(li, 'a', href=href(bin.pid)).text = bin_title(bin)
        
def day2html(day,out=sys.stdout):
    """Output HTML representing a day directory.
    
    Parameters:
    day - the day directory (instance of DayDir)
    out - where to write the representation (default: stdout)
    """
    (html, body) = __html(day.iso8601time)
    __bins2html(body,day)
    return ElementTree(html).write(out, pretty_print=True)

def day2json(day,out=sys.stdout):
    """Output JSON representing a day directory.
    
    Parameters:
    day - the day directory (instance of DayDir)
    out - where to write the representation (default: stdout)
    """
    j = { 'date': day.iso8601time }
    j['bins'] = [bin.pid for bin in day]
    return json.dump(j,out)

# raw data

def __copy_file(path,out):
    f = open(path,'rb')
    shutil.copyfileobj(f, out) # FIXME is this slow?
    f.close()
    
def bin2hdr(bin,out=sys.stdout,detail=DETAIL_HEAD):
    """Output the raw hdr data for a given bin.
    
    Parameters:
    bin - the bin (instance of Bin)
    out - where to write the data default: stdout)
    detail - level of detail (ignored)
    """
    __copy_file(bin.hdr_path,out)
    
def bin2adc(bin,out=sys.stdout,detail=DETAIL_FULL):
    """Output the raw adc data for a given bin.
    
    Parameters:
    bin - the bin (instance of Bin)
    out - where to write the data default: stdout)
    detail - level of detail (ignored)
    """
    __copy_file(bin.adc_path,out)
    
def bin2roi(bin,out=sys.stdout,detail=DETAIL_FULL):
    """Output the raw roi data for a given bin.
    
    Parameters:
    bin - the bin (instance of Bin)
    out - where to write the data default: stdout)
    detail - level of detail (ignored)
    """
    __copy_file(bin.roi_path,out)
    
# some shared code for XML and RDF representations
def __add_headers(bin,root):
    # emit
    #   <dc:date>{bin.iso8601time}</dc:date>
    #   <ifcb:context>{bin.headers()[CONTEXT]}</ifcb:context>
    #   <ifcb:{name}>{bin.headers[name]}</ifcb:{name}>
    #   ...
    SubElement(root, DC_DATE).text = bin.iso8601time
    headers = bin.headers()
    for c in headers[CONTEXT]:
        SubElement(root,IFCB_CONTEXT).text = str(c)
    for name in [name for name,cast in HDR_SCHEMA if headers.has_key(name)]:
        SubElement(root,ifcb_term(name)).text = str(headers[name])

def __target_properties(target, elt):
    # each target is a dict. prepend the ifcb namespace to each dict key and make subtags
    for tag in order_keys(target.info, [column for column,type in ADC_SCHEMA]):
         if tag != PID:
            # emit <ifcb:{tag}>{target.tag}</ifcb:{tag}>
            property = SubElement(elt, ifcb_term(tag))
            property.text = str(target.info[tag])

def __target2xml(target, root=None):
    elt = None
    # emit <ifcb:Target number="{target.targetNumber}"> ...
    if root is not None:
        elt = SubElement(root, IFCB_TARGET, number=str(target.targetNumber))
    else:
        elt = Element(IFCB_TARGET, nsmap=XML_NSMAP, number=str(target.targetNumber))
    pid = target.pid
    # emit <dc:identifier>{target.pid}</dc:identifier>
    SubElement(elt, DC_IDENTIFIER).text = target.pid
    __target_properties(target, elt)
    # emit <dc:hasFormat>{target.pid}.png</dc:hasFormat>
    SubElement(elt, DC_TERMS_HAS_FORMAT).text = target.pid + '.png'
    return elt

def target2xml(target,out=sys.stdout):
    """Output XML representing a given target.
    
    Parameters:
    target - instance of Target
    out - where to write the representation (default: stdout)
    """
    ElementTree(__target2xml(target)).write(out, pretty_print=True)
       
# turn a bin of targets into an xml representation; outputs to given output stream
def bin2xml(bin,out=sys.stdout,detail=DETAIL_SHORT):
    """Output XML representing a given bin.
    
    Parameters:
    bin - instance of Bin
    out - where to write the representation (default: stdout)
    """
    # emit
    # <ifcb:Bin xmlns...>
    #   <dc:identifier>{bin.pid}</dc:identifier>
    #   {headers}
    root = Element(IFCB_BIN, nsmap=XML_NSMAP)
    SubElement(root, DC_IDENTIFIER).text = bin.pid
    __add_headers(bin,root)
    if detail != DETAIL_HEAD:
        target_number = 1
        for target in bin:
            if detail == DETAIL_FULL:
                __target2xml(target, root)
            else:
                # emit <ifcb:Target dc:identifier="{target.pid}"/>
                elt = SubElement(root, IFCB_TARGET)
                elt.set(DC_IDENTIFIER, target.pid)
    return ElementTree(root).write(out, pretty_print=True)

def dq(s):
    return '"' + s + '"'

def bin2csv(bin,out=sys.stdout,detail=DETAIL_FULL):
    """Output CSV representing a given bin
    
    Parameters:
    bin - instance of Bin
    out - where to write the representation (default: stdout)"""
    columns = [column for column,type in ADC_SCHEMA] + ['binID', 'pid', 'stitched', 'targetNumber']
    print >>out, ','.join(columns)
    for target in bin:
        row = []
        for c in columns:
            # add binID, pid, and targetNumber to the row
            if c == 'binID':
                row.append(dq(bin.pid))
            elif c == 'pid':
                row.append(dq(target.pid))
            elif c == 'targetNumber':
                row.append(target.targetNumber)
            else:
                row.append(target.info[c])
        print >>out, ','.join(map(str,row))
    
ATOM_NAMESPACE = 'http://www.w3.org/2005/Atom'
XHTML_NAMESPACE = 'http://www.w3.org/1999/xhtml'

def __feed_bins(fs,n=20,date=None):
    """Get the n latest bins from the filesystem.
    
    Parameters:
    fs - instance of Filesystem
    n - number of bins (default: 20)
    date - as of the given date (default: None which means now)"""
    if date is None:
        result = list(reversed(fs.latest_bins(n)))
        if len(result) != 0:
            return result
        date = time.gmtime()
    # two day window from date. if that's empty, two-day window from bin nearest date
    for end_date_fn in [lambda: date, lambda: fs.nearest_bin(date).time]:
        end_date = end_date_fn()
        two_days_before = time.gmtime(calendar.timegm(end_date) - 172800)
        result = list(reversed(list(fs.all_bins(two_days_before,end_date))))[:n]
    return result
    
def fs2atom(fs,link,n=20,date=None,out=sys.stdout):
    bins2atom(__feed_bins(fs,n,date),link,out)

def bins2atom(bins,link,out=sys.stdout):
    """Output an Atom feed of recent bins from the given filesystem.
    
    Parameters:
    fs - the filesystem (instance of Filesystem)
    link - the feed's self-link
    n - the number of recent entries to include (default: 20)
    date - the latest date to return (default: now)
    out - where to write the feed (default: stdout)
    """
    nsmap = { None: ATOM_NAMESPACE }
    xhtml = { None: 'http://www.w3.org/1999/xhtml' }
    feed = Element('feed', nsmap=nsmap)
    SubElement(feed, 'title').text = 'Imaging FlowCytobot most recent data'
    SubElement(feed, 'subtitle').text = 'Live marine phytoplankton cytometry with imagery'
    author = SubElement(feed, 'author')
    SubElement(author, 'name').text = 'Imaging FlowCytobot'
    SubElement(feed, 'link', href=link, rel='self')
    SubElement(feed, 'id').text = link
    if len(bins) > 0:
        SubElement(feed, 'updated').text = bins[0].iso8601time
    else:
        SubElement(feed,'updated').text = iso8601utcnow()
    for bin in bins:
        t = SubElement(feed, 'entry')
        SubElement(t, 'title').text = bin_title(bin)
        SubElement(t, 'link', href=bin.pid, rel='alternate', type='application/rdf+xml')
        SubElement(t, 'link', href=bin.pid+'.xml', rel='alternate', type='text/xml')
        SubElement(t, 'link', href=bin.pid+'.json', rel='alternate', type='application/json')
        SubElement(t, 'id').text = bin.pid
        SubElement(t, 'updated').text = bin.iso8601time
        content = SubElement(t, 'content', type='xhtml')
        div = SubElement(content, QName(XHTML_NAMESPACE, 'div'), nsmap=xhtml)
        headers = bin.headers()
        for header in sorted(headers.keys()):
            SubElement(div, 'div').text = header + ': ' + str(headers[header])
    ElementTree(feed).write(out, pretty_print=True)

def fs2rss(fs,link,n=20,date=None,out=sys.stdout):
    bins2rss(__feed_bins(fs,n,date),link,out)

def bins2rss(bins,link,out=sys.stdout):
    """Output an RSS 2.0 feed of recent bins from the given filesystem.
    
    Parameters:
    fs - the filesystem (instance of Filesystem)
    link - the feed's self-link
    n - the number of recent entries to include (default: 20)
    date - the latest date to return (default: now)
    out - where to write the feed (default: stdout)
    """
    xhtml = { None: 'http://www.w3.org/1999/xhtml' }
    rss = Element('rss', version='2.0')
    feed = SubElement(rss, 'channel', nsmap=dict(atom=ATOM_NAMESPACE))
    SubElement(feed, 'title').text = 'Imaging FlowCytobot most recent data'
    SubElement(feed, 'description').text = 'Live marine phytoplankton cytometry with imagery'
    #SubElement(feed, 'author').text = 'Imaging FlowCytobot'
    SubElement(feed, 'link').text = link
    SubElement(feed, '{%s}link' % ATOM_NAMESPACE, rel='self', href=link)
    SubElement(feed, 'pubDate').text = bins[0].rfc822time
    SubElement(feed, 'ttl').text = '20'
    for bin in bins:
        t = SubElement(feed, 'item')
        SubElement(t, 'title').text = bin_title(bin)
        SubElement(t, 'guid').text = bin.pid
        SubElement(t, 'link').text = bin.pid + '.html'
        SubElement(t, 'pubDate').text = bin.rfc822time
        content = SubElement(t, 'description')
        headers = bin.headers()
        # generate a brief HTML description of the bin headers
        body = '\n'.join(['<div>%s: %s</div>' % (header, headers[header]) for header in sorted(headers.keys())])
        img = '<img src="'+bin.pid+'/mosaic/small.jpg">'
        content.text = '<div>%s%s</div>' % (img,body)
    ElementTree(rss).write(out, pretty_print=True)

def fs2html_feed(fs,link,n=20,date=None,out=sys.stdout):
    bins2html_feed(__feed_bins(fs,n,date),out)

def bins2html_feed(bins,out=sys.stdout):
    """Output an HTML-formatted "feed" of recent bins from the given filesystem.
    
    Parameters:
    fs - the filesystem (instance of Filesystem)
    link - the feed's self-link
    n - the number of recent entries to include (default: 20)
    date - the latest date to return (default: now)
    out - where to write the feed (default: stdout)
    """
    (html, body) = __html('Imaging FlowCytobot most recent data')
    __bins2html(body, bins)
    ElementTree(html).write(out, pretty_print=True)

def fs2json_feed(fs,link,n,date=None,out=sys.stdout):
    bins2json_feed(__feed_bins(fs,n,date),out)

def bins2json_feed(bins,out=sys.stdout):
    """Output an JSON-formatted "feed" of recent bins from the given filesystem.
    
    Parameters:
    fs - the filesystem (instance of Filesystem)
    link - the feed's self-link
    n - the number of recent entries to include (default: 20)
    date - the latest date to return (default: now)
    out - where to write the feed (default: stdout)
    """
    json.dump([bin.properties(True) for bin in bins],out)

def pretty_property_name(propName):
    """Decamelize a property name"""
    return decamel(propName)

def bin2html(bin,out=sys.stdout,detail=DETAIL_SHORT):
    """Output HTML representing a given bin.
    
    Parameters:
    bin - instance of Bin
    out - where to write the representation (default: stdout)
    detail - level of detail (default: DETAIL_SHORT)
    """
    # emit
    # <html>
    #   <head>
    #     <title>{bin_title(bin)}</title>
    #   </head>
    #   <body>
    #     <div class="title">{bin_title(bin)}</div>
    #     <div class="properties">
    #       ...
    (html, body) = __html(bin_title(bin))
    properties = Sub(body, 'div', 'properties')
    for k in order_keys(bin.properties(), [column for column,type in HDR_SCHEMA]):
        # emit
        # <div class="property">
        #   <div class="label">{pretty_property_name(k)}</div>
        #   <div class="value">{bin.properties()[k]}</div>
        # </div>
        prop = Sub(properties, 'div', 'property')
        Sub(prop, 'div', 'label').text = pretty_property_name(k)
        Sub(prop, 'div', 'value').text = str(bin.properties()[k])
    if detail != DETAIL_HEAD:
        # emit
        # <div class="targets">
        #   <ul class="targets">
        #     ...
        targets = Sub(body, 'div', 'targets')
        ul = Sub(targets,'ul','targets')
        for target in bin:
            # emit
            # <li class="target">
            #   <a href="{href(target.pid)}">{target_title(target)} {target area}B</a>
            # </li>
            li = Sub(ul, 'li', 'target')
            a = SubElement(li, 'a', href=href(target.pid))
            a.text = target_title(target)
            a.tail = ' %dB' % (target.height * target.width)
    ElementTree(html).write(out, pretty_print=True)

def target2html(target,out=sys.stdout):
    """Output HTML representing a given target
    
    Parameters:
    target - instance of Target
    out - where to write the representation (default: stdout)
    """
    (html, body) = __html(target_title(target))
    # emit
    # <div class="image">
    #   <img src="{target.pid}.png" class="image">
    # </div>
    id = Sub(body, 'div', 'image')
    img = SubElement(id, 'img', src=href(target.pid,'png'))
    img.set('class','image')
    # emit
    # <div class="properties">
    #   <div class="property">
    #     <div class="label">bin</div>
    #     <div class="bin value">
    #       <a href="{target.bin.pid}">{bin_title(target.bin)}</a>
    #     </div>
    #     ...
    properties = Sub(body, 'div', 'properties')
    parent_link = Sub(properties, 'div', 'property')
    Sub(parent_link, 'div', 'label').text = 'bin'
    link = Sub(parent_link, 'div', 'bin value')
    SubElement(link, 'a', href=href(target.bin.pid)).text = bin_title(target.bin)
    for k in order_keys(target.info, [column for column,type in ADC_SCHEMA]):
        # emit
        # <div class="property">
        #   <div class="label">{pretty_property_name(k)}</div>
        #   <div class="value">{target.info[k]}</div>
        # </div>
        prop = Sub(properties, 'div', 'property')
        Sub(prop, 'div', 'label').text = pretty_property_name(k)
        Sub(prop, 'div', 'value').text = str(target.info[k])
    ElementTree(html).write(out, pretty_print=True)
        
def __target2rdf(target,parent):
    elt = SubElement(parent, IFCB_TARGET)
    elt.set(RDF_ABOUT, target.pid)
    __target_properties(target, elt)
    SubElement(elt, DC_TERMS_HAS_FORMAT).text = target.pid + '.png'

def target2rdf(target,out=sys.stdout):
    """Output RDF representing a given target
    
    Parameters:
    target - instance of Target
    out - where to write the representation (default: stdout)
    """
    rdf = __rdf()
    __target2rdf(target,rdf)
    return ElementTree(rdf).write(out, pretty_print=True)
    
def bin2rdf(bin,out=sys.stdout,detail=DETAIL_SHORT):
    """Output RDF representing a given bin
    
    Parameters:
    bin - instance of Bin
    out - where to write the representation (default: stdout)
    detail - level of detail (default: DETAIL_SHORT)
    """
    rdf = __rdf()
    root = SubElement(rdf, IFCB_BIN)
    pid = bin.pid
    root.set(RDF_ABOUT, pid)
    __add_headers(bin,root)
    SubElement(root, DC_TERMS_HAS_FORMAT).text = bin.pid + '.xml'
    SubElement(root, DC_TERMS_HAS_FORMAT).text = bin.pid + '.json'
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
                t.set(RDF_ABOUT, target.pid)
    return ElementTree(rdf).write(out, pretty_print=True)

def bin_as_json(bin,detail=DETAIL_SHORT):
    """Generate JSON representation of bin
    
    Parameters:
    bin - instance of Bin
    detail - level of detail (default: DETAIL_SHORT)
    """
    result = bin.properties()
    if detail == DETAIL_FULL:
        result['targets'] = [target.info for target in bin];
    elif detail != DETAIL_HEAD:
        result['targets'] = [target.pid for target in bin];
    return result

# turn a bin of targets into a json representation
def bin2json(bin,out=sys.stdout,detail=DETAIL_FULL):
    """Output JSON representing a given bin
    
    Parameters:
    bin - instance of Bin
    out - where to write the representation (default: stdout)
    detail - level of detail (default: DETAIL_SHORT)
    """
    result = bin_as_json(bin,detail)
    return json.dump(result,out)

def target2json(target,out=sys.stdout):
    """Output JSON representing a given target
    
    Parameters:
    target - instance of Target
    out - where to write the representation (default: stdout)
    """
    return json.dump(target.info,out)

# this is the only method of writing images that works for all of PIL's formats
def __stream_image(target,format,out,scale=1.0):
    """Output the image of a target in any format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Taret
    format - an image format supported by PIL
    out - where to write the data to
    scale - scaling factor for image dimensions (default: 1.0)
    """
    image = target.image()
    if scale != 1.0:
        image = image.resize((int(target.height * scale), int(target.width * scale)), Image.ANTIALIAS)
    with tempfile.SpooledTemporaryFile() as flo:
        image.save(flo,format)
        flo.seek(0)
        shutil.copyfileobj(flo, out)

def target2image(target,format='PNG',out=sys.stdout,scale=1.0):
    """Output the image of a target in any format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    format - an image format supported by PIL (default: png)
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    format = string.upper(format)
    __stream_image(target,format,out,scale)
    
def target2png(target,out=sys.stdout,scale=1.0):
    """Output the image of a target in png format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    target2image(target,'PNG',out,scale)

def target2jpg(target,out=sys.stdout,scale=1.0):
    """Output the image of a target in jpg format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    target2image(target,'JPEG',out,scale)

def target2bmp(target,out=sys.stdout,scale=1.0):
    """Output the image of a target in bmp format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    target2image(target,'BMP',out,scale)

def target2gif(target,out=sys.stdout,scale=1.0):
    """Output the image of a target in gif format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    target2image(target,'GIF',out)
    
def target2tiff(target,out=sys.stdout,scale=1.0):
    """Output the image of a target in tiff format to an output stream (resizing if desired).
    
    Parameters:
    target - instance of Target
    out - where to write the data to (default: stdout)
    scale - scaling factor for image dimensions (default: 1.0)
    """
    target2image(target,'TIFF',out)

def bin2zip(bin,out=sys.stdout,detail=None):
    buffer = io.BytesIO()
    with tempfile.SpooledTemporaryFile() as temp:
        z = ZipFile(temp,'w',ZIP_DEFLATED)
        bin2csv(bin,buffer)
        z.writestr(bin.lid + '.csv', buffer.getvalue())
        buffer.seek(0)
        buffer.truncate()
        # xml as well, including header info
        bin2xml(bin,buffer)
        z.writestr(bin.lid + '.xml', buffer.getvalue())
        for target in bin:
            buffer.seek(0)
            buffer.truncate()
            __stream_image(target,'PNG',buffer)
            z.writestr(target.lid + '.png', buffer.getvalue())
        z.close()
        temp.seek(0)
        shutil.copyfileobj(temp, out)
        out.flush()
        
