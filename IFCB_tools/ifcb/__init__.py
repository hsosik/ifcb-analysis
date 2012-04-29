"""IFCB utilities"""

from config import DATA_NAMESPACE

TERM_NAMESPACE = 'http://ifcb.whoi.edu/terms#'

def pid(local_id,namespace=None):
    if namespace is None:
        namespace = DATA_NAMESPACE
    return ''.join([namespace, local_id])
    
def term(local_id):
    return ''.join([TERM_NAMESPACE, local_id])

def lid(pid,namespace=None):
    if namespace is None:
        namespace = DATA_NAMESPACE
    return pid.replace(namespace,'',1)
