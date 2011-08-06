import xml.dom.minidom
from ifcb import namespace, dataNamespace

def rois2xml(rois):
    d = Document()
    top = d.createElementNS(namespace,'rois')
    d.appendChild(top)
    for roi in rois:
        roiElt = d.createElementNs(namespace,'roi')
        top.appendChild(roiElt)
    return d