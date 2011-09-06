#!/usr/bin/python
import ifcb
import cgi
import cgitb
from ifcb.io import DETAIL_FULL, DETAIL_SHORT, DETAIL_HEAD
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2json, bin2xml, bin2rdf, target2rdf, target2xml, target2json, target2png, target2jpg, target2gif, target2bmp, target2tiff, day2rdf, day2xml, day2json, day2html, bin2html, target2html, bin2hdr, bin2adc, bin2roi
from ifcb.io.file import BinFile, Target
from ifcb.io.dir import DayDir
import os.path
import re
from config import FS_ROOTS
import sys

"""RESTful service resolving an IFCB permanent ID (pid) + format parameter to an appropriate representation"""

if __name__ == '__main__':
    cgitb.enable()
    pid = cgi.FieldStorage().getvalue('pid')
    format = cgi.FieldStorage().getvalue('format','rdf')
    detail = cgi.FieldStorage().getvalue('detail', DETAIL_SHORT)
    object = Filesystem(FS_ROOTS).resolve(pid)
    print 'Content-type: '+{ 'rdf': 'text/xml',
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
                'roi': 'application/octet-stream' }[format] + '\n';
    if isinstance(object,BinFile):
        { 'rdf': bin2rdf,
          'xml': bin2xml,
          'html': bin2html,
          'json': bin2json,
          'adc': bin2adc,
          'roi': bin2roi,
          'hdr': bin2hdr }[format](object,sys.stdout,detail)
    elif isinstance(object,Target):
        { 'rdf': target2rdf,
          'xml': target2xml,
          'html': target2html,
          'json': target2json,
          'png': target2png,
          'jpg': target2jpg,
          'gif': target2gif,
          'bmp': target2bmp,
          'tiff': target2tiff }[format](object)
    elif isinstance(object,DayDir):
        { 'rdf': day2rdf,
          'xml': day2xml,
          'html': day2html,
          'json': day2json }[format](object)
    
