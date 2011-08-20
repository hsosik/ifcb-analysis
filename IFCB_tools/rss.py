#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
from ifcb.io.convert import fs2atom, fs2json
from config import FS, ATOM

if __name__ == '__main__':
    cgitb.enable()
    format = cgi.FieldStorage().getvalue('format','atom')
    mime = dict(atom='application/atom+xml', json='application/json')[format]
    print 'Content-type: %s\n' % (mime)
    dict(atom=fs2atom, json=fs2json)[format](FS,ATOM)
