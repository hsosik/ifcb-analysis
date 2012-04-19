from config import CONFIG_FILE
from ifcb.util import get_config
import re

CONFIG_SCHEMA = [
('stitch', 'bool'),
('use_memcached', 'bool'),
('memcached_servers', 'list'),
('url_base', 'str'),
('data_ttl', 'int'),
('data_namespace', 'str'),
('feed', 'str'),
('fs_roots', 'list'),
('mod_roots', 'list'),
('blob_roots', 'list'),
('psql_connect', 'str')
]

# read a config file and massage some value types
def config(name):
    c = get_config(CONFIG_FILE,name)
    for key,val_type in CONFIG_SCHEMA:
        try:
            if val_type == 'list':
                c[key] = re.split(r'\s*,\s*',c[key])
            elif val_type == 'bool':
                c[key] = c[key] == 'True'
            elif val_type == 'int':
                c[key] = int(c[key])
        except KeyError:
            pass
    return c
    
