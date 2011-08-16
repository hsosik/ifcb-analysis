"""IFCB utilities"""

# TODO choose a namespace URL prefix that is appropriate to IFCB's origin and place in the world
TERM_NAMESPACE = 'http://ifcb.whoi.edu/terms#'
DATA_NAMESPACE = 'http://ifcb-data.whoi.edu/'

def pid(local_id):
    ''.join([DATA_NAMESPACE, local_id])
    
def term(local_id):
    ''.join([TERM_NAMESPACE, local_id])

def lid(pid):
    return pid.replace(DATA_NAMESPACE,'',1)
