#!/usr/bin/python
import ifcb
import cgi
from ifcb.io import DETAIL_FULL, DETAIL_SHORT, DETAIL_HEAD
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2json, bin2xml, bin2rdf, target2rdf, target2xml, target2json, target2image, day2rdf, day2xml, day2json, day2html, bin2html, target2html, bin2hdr, bin2adc, bin2roi, bin2csv, bin2zip
from ifcb.io.file import BinFile, Target
from ifcb.io.dir import DayDir
from ifcb.io.stitching import StitchedBin, StitchedTarget
import os.path
import re
from config import FS_ROOTS, DATA_TTL
import sys

"""RESTful service resolving an IFCB permanent ID (pid) + format parameter to an appropriate representation"""

# map extensions to MIME types
MIME_MAP = {
  'rdf': 'text/xml',
  'json': 'application/json',
  'xml': 'text/xml',
  'html': 'text/html',
  'png': 'image/png',
  'jpg': 'image/jpeg',
  'gif': 'image/gif',
  'bmp': 'image/bmp',
  'tiff': 'image/tiff',
  'hdr': 'text/plain',
  'adc': 'text/csv',
  'csv': 'text/csv',
  'zip': 'application/zip',
  'roi': 'application/octet-stream'
}

# map image MIME types to PIL image formats
IMAGE_FORMATS = {
  'image/png': 'png',
  'image/jpeg': 'jpeg',
  'image/gif': 'gif',
  'image/bmp': 'bmp',
  'image/tiff': 'tiff',
}

if __name__ == '__main__':
    out = sys.stdout
    pid = cgi.FieldStorage().getvalue('pid')
    format = 'rdf' # default format is RDF, to support "linked open data"
    if re.search(r'\.[a-z]+$',pid): # does the pid have an extension?
        (pid, ext) = os.path.splitext(pid)
        format = re.sub(r'^\.','',ext) # the extension minus the "." is the "format"
    format = cgi.FieldStorage().getvalue('format',format) # specified format overrides
    detail = cgi.FieldStorage().getvalue('detail', DETAIL_SHORT) # default detail is "short"
    scale = float(cgi.FieldStorage().getvalue('scale','1.0')) # default scale is "1.0"
    try:
        object = Filesystem(FS_ROOTS).resolve(pid) # resolve the object
        mime_type = MIME_MAP[format] # compute its MIME type
        headers = ['Content-type: %s' % mime_type,
                   'Cache-control: max-age=%d' % DATA_TTL,
                   '']
        for h in headers:
            print h
        if isinstance(object,BinFile) or isinstance(object,StitchedBin): # is the object a bin?
            { 'rdf': bin2rdf,
              'xml': bin2xml,
              'html': bin2html,
              'json': bin2json,
              'adc': bin2adc,
              'csv': bin2csv,
              'roi': bin2roi,
              'hdr': bin2hdr,
              'zip': bin2zip }[format](object,out,detail) # convert it to format
        elif re.search('^image/', mime_type): # is it an image?
            target2image(object, IMAGE_FORMATS[mime_type], out, scale) # produce the image
        elif isinstance(object,Target) or isinstance(object,StitchedTarget): # is it a target?
            { 'rdf': target2rdf,
              'xml': target2xml,
              'html': target2html,
              'json': target2json }[format](object) # convert it to format
        elif isinstance(object,DayDir): # is it a day dir?
            { 'rdf': day2rdf,
              'xml': day2xml,
              'html': day2html,
              'json': day2json }[format](object) # convert it to format
    except KeyError:
        print 'Status: 404\n'
