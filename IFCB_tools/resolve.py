#!/usr/bin/python
import ifcb
import cgi
import cgitb
from ifcb.io.path import Filesystem
from ifcb.io.convert import bin2json, bin2xml, bin2rdf, target2rdf, target2xml, target2json
from ifcb.io.file import BinFile, Target
import os.path
import re
# script for returning a bin in JSON format given the PID

FS = Filesystem(['/Volumes/G on K/IFCB/ifcb_data_MVCO_jun06', '/Volumes/J_IFCB/ifcb_data_MVCO_jun06'])

if __name__ == '__main__':
    cgitb.enable()
    (pid, ext) = os.path.splitext(cgi.FieldStorage().getvalue('pid'))
    format = 'rdf' # default
    if ext != '':
        format = re.sub('^.','',ext)
    object = FS.resolve(pid)
    print 'Content-type: '+{ 'rdf': 'application/rdf+xml',
                'json': 'application/json',
                'xml': 'text/xml' }[format] + '\n';
    if isinstance(object,BinFile):
        { 'rdf': bin2rdf,
          'xml': bin2xml,
          'json': bin2json }[format](object)
    elif isinstance(object,Target):
        { 'rdf': target2rdf,
          'xml': target2xml,
          'json': target2json }[format](object)
    