#!/usr/bin/python
from sys import argv, stdout
import cgi
import cgitb
from ifcb.io.convert import fs2atom, fs2json_feed, fs2html_feed
from ifcb.io.path import Filesystem
from config import FS_ROOTS, ATOM

if __name__ == '__main__':
    cgitb.enable()
    format = cgi.FieldStorage().getvalue('format','atom')
    mime = dict(atom='application/atom+xml', json='application/json', html='text/html')[format]
    print 'Content-type: %s\n' % (mime)
    dict(atom=fs2atom, json=fs2json_feed, html=fs2html_feed)[format](Filesystem(FS_ROOTS),ATOM)
