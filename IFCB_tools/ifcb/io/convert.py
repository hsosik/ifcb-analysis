import ifcb
from ifcb.io import Bin, PID
from lxml import etree
from lxml.etree import ElementTree, QName, Element, SubElement
from rdflib import ConjunctiveGraph, Namespace, Literal, URIRef

# turn a bin of roi's into an xml representation
def rois2xml(bin,out):
    dc = 'http://purl.org/dc/elements/1.1/'
    # ifcb namespace is the default
    nsmap = { None: ifcb.namespace, 'dc': dc }
    # top level is called "bin"
    root = Element(QName(ifcb.namespace, 'bin'), nsmap=nsmap)
    SubElement(root,QName(dc,'identifier')).text = bin.pid()
    roi_number = 1
    for roi_info in bin.all_rois():
        roi = SubElement(root,QName(ifcb.namespace, 'roi'), number=str(roi_number))
        roi_number = roi_number + 1
        SubElement(roi,QName(dc,'identifier')).text = roi_info[PID]
        # each roi is a dict. prepend the ifcb namespace to each dict key and make subtags
        for tag, value in roi_info.items():
            if tag != PID:
                property = SubElement(roi,QName(ifcb.namespace,tag))
                property.text = str(value)
    return ElementTree(root).write(out, pretty_print=True)

def rois2rdf(bin,out):
    ifcbns = Namespace(ifcb.namespace)
    data = Namespace(ifcb.dataNamespace)
    rdf = Namespace('http://www.w3.org/1999/02/22-rdf-syntax-ns#')
    # dc = Namespace('http://purl.org/dc/elements/1.1/')
    g = ConjunctiveGraph()
    seq = URIRef(bin.pid() + '/rois')
    g.add((URIRef(bin.pid()), rdf['type'], ifcbns['Bin']))
    g.add((URIRef(bin.pid()), ifcbns['hasRois'], seq))
    roi_number = 1
    for roi_info in bin.all_rois():
        roi = URIRef(roi_info[PID])
        g.add((seq, rdf['_%d'%roi_number], roi))
        roi_number = roi_number + 1 
        g.add((roi, rdf['type'], ifcbns['ROI']))
        for tag, value in roi_info.items():
            if tag != PID:
                g.add((roi, ifcbns[tag], Literal(str(value))))
    g.namespace_manager.bind('ifcb',ifcb.namespace)
    g.serialize(out, format='pretty-xml')