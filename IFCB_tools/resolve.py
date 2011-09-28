#!/usr/bin/python
import ifcb
import cgi
import cgitb
from ifcb.io import DETAIL_FULL, DETAIL_SHORT, DETAIL_HEAD
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2json, bin2xml, bin2rdf, target2rdf, target2xml, target2json, target2image, day2rdf, day2xml, day2json, day2html, bin2html, target2html, bin2hdr, bin2adc, bin2roi
from ifcb.io.file import BinFile, Target
from ifcb.io.dir import DayDir
import os.path
import re
from config import FS_ROOTS
import sys

"""RESTful service resolving an IFCB permanent ID (pid) + format parameter to an appropriate representation"""

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
  'roi': 'application/octet-stream'
}

IMAGE_FORMATS = {
  'image/png': 'png',
  'image/jpeg': 'jpeg',
  'image/gif': 'gif',
  'image/bmp': 'bmp',
  'image/tiff': 'tiff',
}

if __name__ == '__main__':
    cgitb.enable()
    out = sys.stdout
    pid = cgi.FieldStorage().getvalue('pid')
    format = 'rdf'
    if re.search(r'\.[a-z]+$',pid):
        (pid, ext) = os.path.splitext(pid)
        format = re.sub(r'^\.','',ext)
    format = cgi.FieldStorage().getvalue('format',format)
    detail = cgi.FieldStorage().getvalue('detail', DETAIL_SHORT)
    scale = float(cgi.FieldStorage().getvalue('scale','1.0'))
    object = Filesystem(FS_ROOTS).resolve(pid)
    mime_type = MIME_MAP[format]
    print 'Content-type: %s\n' % mime_type
    if isinstance(object,BinFile):
        { 'rdf': bin2rdf,
          'xml': bin2xml,
          'html': bin2html,
          'json': bin2json,
          'adc': bin2adc,
          'csv': bin2csv,
          'roi': bin2roi,
          'hdr': bin2hdr }[format](object,out,detail)
    elif re.search('^image/', mime_type):
        target2image(object, IMAGE_FORMATS[mime_type], out, scale)
    elif isinstance(object,Target):
        { 'rdf': target2rdf,
          'xml': target2xml,
          'html': target2html,
          'json': target2json }[format](object)
    elif isinstance(object,DayDir):
        { 'rdf': day2rdf,
          'xml': day2xml,
          'html': day2html,
          'json': day2json }[format](object)
    
