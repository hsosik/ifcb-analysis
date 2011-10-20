from urllib2 import urlopen, Request
import json
from StringIO import StringIO
from PIL import Image
from collections import namedtuple

Roi = namedtuple('Roi', ['image','x','y','w','h'])

def get_image(pid):
    u = urlopen(pid + '.png')
    i = StringIO(u.read())
    u.close()
    return Image.open(i)

def get_image_properties(pid):
    return json.loads(''.join(urlopen(Request(pid + '.json'))))

def stitch(pids):
    rois = {}
    for pid in pids:
        p = get_image_properties(pid)
        print p
        i = get_image(pid)
        xywh = [p[x] for x in ['left','bottom','width','height']]
        rois[pid] = Roi._make([i] + xywh)
    x = min([roi.x for roi in rois.values()])
    y = min([roi.y for roi in rois.values()])
    w = max([roi.x + roi.w for roi in rois.values()]) - x
    h = max([roi.y + roi.h for roi in rois.values()]) - y
    s = Image.new('L',(h,w)) # rotated 90
    for roi in rois.values():
        s.paste(roi.image, (roi.y - y, roi.x - x))
    return s
    
if __name__=='__main__':
    pids = [
            #'http://ifcb-data.whoi.edu/IFCB1_2011_290_060847_00008',
            #'http://ifcb-data.whoi.edu/IFCB1_2011_290_060847_00009'
            'http://ifcb-data.whoi.edu/IFCB1_2011_292_022614_02752.html',
            'http://ifcb-data.whoi.edu/IFCB1_2011_292_022614_02753.html'
    ]
    s = stitch(pids)
    pathname = 'stitch.png'
    s.save(pathname,'png')
    