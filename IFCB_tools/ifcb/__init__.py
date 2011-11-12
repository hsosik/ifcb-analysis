"""IFCB utilities"""

from config import DATA_NAMESPACE

TERM_NAMESPACE = 'http://ifcb.whoi.edu/terms#'

def pid(local_id):
    return ''.join([DATA_NAMESPACE, local_id])
    
def term(local_id):
    return ''.join([TERM_NAMESPACE, local_id])

def lid(pid):
    return pid.replace(DATA_NAMESPACE,'',1)
