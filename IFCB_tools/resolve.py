#!/usr/bin/python
import ifcb
import cgi
import cgitb
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2json, bin2xml, bin2rdf, target2rdf, target2xml, target2json, target2png, target2jpg, target2gif, target2bmp, target2tiff, day2rdf, day2xml, day2json
from ifcb.io.file import BinFile, Target
from ifcb.io.dir import DayDir
import os.path
import re
from config import FS

# script for returning a bin in JSON format given the PID

if __name__ == '__main__':
    cgitb.enable()
    (pid, ext) = os.path.splitext(cgi.FieldStorage().getvalue('pid'))
    format = 'rdf' # default
    if ext != '':
        format = re.sub('^.','',ext)
    object = FS.resolve(pid)
    print 'Content-type: '+{ 'rdf': 'text/xml',
                'json': 'application/json',
                'xml': 'text/xml',
                'png': 'image/png',
                'jpg': 'image/jpeg',
                'gif': 'image/gif',
                'bmp': 'image/bmp',
                'tiff': 'image/tiff' }[format] + '\n';
    if isinstance(object,BinFile):
        { 'rdf': bin2rdf,
          'xml': bin2xml,
          'json': bin2json }[format](object)
    elif isinstance(object,Target):
        { 'rdf': target2rdf,
          'xml': target2xml,
          'json': target2json,
          'png': target2png,
          'jpg': target2jpg,
          'gif': target2gif,
          'bmp': target2bmp,
          'tiff': target2tiff }[format](object)
    elif isinstance(object,DayDir):
        { 'rdf': day2rdf,
          'xml': day2xml,
          'json': day2json }[format](object)
    
