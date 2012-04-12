from flask import Flask, url_for, Response, request
from blob_extraction import dest 
import shutil
from StringIO import StringIO
from ifcb.util import iso8601utcnow
import sys
import os
import json

app = Flask(__name__)
app.debug = True

@app.route('/deposit/<path:pid>',methods=['POST'])
def deposit(pid):
    zipdata = request.data
    destpath = dest(pid)
    try:
        os.makedirs(os.path.dirname(destpath))
    except:
        pass
    with open(destpath,'w') as out:
        shutil.copyfileobj(StringIO(zipdata), out)
    utcnow = iso8601utcnow()
    message = '%s wrote %d bytes to %s' % (utcnow, len(zipdata), destpath)
    receipt = dict(
        status='OK',
        time=utcnow,
        message=message,
        pid=pid,
        path=destpath
    )
    return Response(json.dumps(receipt), mimetype='application/json')

if __name__=='__main__':
    try:
        app.run(host=sys.argv[1])
    except:
        app.run(host='0.0.0.0')
