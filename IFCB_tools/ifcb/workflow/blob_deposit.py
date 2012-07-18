from flask import Flask, url_for, Response, request
import shutil
from StringIO import StringIO
from ifcb.util import iso8601utcnow
import sys
import os
import json
import urllib2 as urllib
from blob_storage import BlobStorage
import re
from oii.config import get_config

app = Flask(__name__)
app.debug = True

def jsonr(s):
    return Response(json.dumps(s), mimetype='application/json')

@app.route('/deposit/blobs/<path:pid>',methods=['POST'])
def deposit_impl(pid):
    zipdata = request.data
    destpath = app.config['BLOB_STORAGE'].dest(pid)
    try:
        os.makedirs(os.path.dirname(destpath))
    except:
        pass
    destpath_part = destpath+'.part'
    with open(destpath_part,'w') as out:
        shutil.copyfileobj(StringIO(zipdata), out)
    os.rename(destpath_part, destpath)
    utcnow = iso8601utcnow()
    message = '%s wrote %d bytes to %s' % (utcnow, len(zipdata), destpath)
    return jsonr(dict(
        status='OK',
        time=utcnow,
        message=message,
        pid=pid,
        path=destpath
    ))
                     
@app.route('/exists/blobs/<path:pid>')
def exists_impl(pid):
    destpath = app.config['BLOB_STORAGE'].dest(pid)
    exists = os.path.exists(destpath)
    if exists:
        message = '%s %s FOUND at %s' % (iso8601utcnow(), pid, destpath)
    else:
        message = '%s %s NOT FOUND at %s' % (iso8601utcnow(), pid, destpath)
    utcnow = iso8601utcnow()
    return jsonr(dict(
        exists=exists,
        time=utcnow,
        message=message,
        pid=pid,
        path=destpath
    ))

# client code

class BlobDeposit(object):
    def __init__(self,url_base='http://localhost:5000'):
        self.url_base = url_base

    def exists(self,pid):
        req = urllib.Request('%s/exists/blobs/%s' % (self.url_base, pid))
        resp = json.loads(urllib.urlopen(req).read())
        return resp['exists']

    def deposit(self,pid,zipfile):
        with open(zipfile,'r') as inzip:
            zipdata = inzip.read()
            req = urllib.Request('%s/deposit/blobs/%s' % (self.url_base, pid), zipdata)
            req.add_header('Content-type','application/x-ifcb-blobs')
            resp = json.loads(urllib.urlopen(req).read())
            return resp

if __name__=='__main__':
    config = get_config('./blob.conf', sys.argv[1])
    blob_storage = BlobStorage(config)
    app.config['BLOB_STORAGE'] = blob_storage
    (h,p) = re.match(r'http://(.*):(\d+)',config.blob_deposit).groups()
    app.run(host=h, port=int(p))
