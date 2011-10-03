# Self-link included in ATOM feed
FEED = 'http://ifcb-data.whoi.edu/feed'

# Where the data is mounted
FS_ROOTS = ['/mnt/ifcb_g/IFCB/ifcb_data_MVCO_jun06', '/mnt/ifcb_j/ifcb_data_MVCO_jun06']

# Enable caching
USE_MEMCACHED = True
MEMCACHED_SERVERS = ['127.0.0.1']

URL_BASE = ''
# uncomment for debugging
#URL_BASE = 'http://localhost/~jfutrelle/sandbox/ifcb/resolve.py?pid='
