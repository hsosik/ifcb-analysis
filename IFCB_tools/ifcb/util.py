from functools import wraps
import re
import string
from math import floor
import time
from time import time, strftime, gmtime
from sys import stdout
import datetime
import pytz
import hashlib

# adapted from http://argandgahandapandpa.wordpress.com/2009/03/29/python-generator-to-list-decorator/
def gen2dict(func):
    @wraps(func)
    def patched(*args, **kwargs):
        return dict(*func(*args, **kwargs))
    return patched

# adapted from http://argandgahandapandpa.wordpress.com/2009/03/29/python-generator-to-list-decorator/
def gen2list(gen):
    "Convert a generator into a function which returns a list"
    def patched(*args, **kwargs):
        return list(gen(*args, **kwargs))
    return patched

# order the keys of a dict according to a sequence
# any keys in the sequence that are not present in the dict will not be listed
# any keys in the dict that are not in the sequence will be listed in alpha order
def order_keys(d,s):
    sk = [key for key in s if key in d.keys()]
    dk = sorted([key for key in d.keys() if key not in s])
    return sk + dk

# convert camelCase to Title Case
def decamel(s):
    return string.capwords(re.sub(r'([a-z])([A-Z]+)',r'\1 \2',s))
    
def apply_defaults(dict,defaults):
    for k in defaults.keys():
        if not dict.has_key(k):
            dict[k] = defaults[k]

def iso8601utcnow():
    t = time()
    ms = int(floor((t * 1000) % 1000))
    return '%s.%03dZ' % (strftime('%Y-%m-%dT%H:%M:%S',gmtime(t)),ms)

def utcdatetime(struct_time=time()):
    return datetime.datetime(*struct_time[:6], tzinfo=pytz.timezone('UTC'))

def csvrep(value,none=''):
    if value is None:
        return none
    s = str(value)
    if ' ' in s:
        s = "'%s'" % s
    return s

def log_msg(msg,fields=[],out=stdout):
    print >> out, ' '.join([iso8601utcnow(),msg] + [csvrep(f,'-') for f in fields])

def sha1_string(data):
    m = hashlib.sha1()
    m.update(data)
    return m.hexdigest()

def sha1_filelike(filelike):
    m = hashlib.sha1()
    while True:
        s = filelike.read()
        if len(s) == 0:
            break
        else:
            m.update(s)
    return m.hexdigest()

def sha1_file(pathname):
    with open(pathname,'rb') as fl:
        return sha1_filelike(fl)

def get_config(pathname,subconf_name):
    config = {}
    current_subconf = None
    with open(pathname,'r') as configfile:
        for line in configfile:
            line = line.strip()
            if re.match('^#',line): # comment
                continue
            try:
                current_subconf = re.match(r'^\[(.*)\]',line).groups(0)[0].strip()
            except:
                pass
            try:
                (key, value) = re.match(r'^([^=]+)=(.*)',line).groups()
                key = key.strip()
                value = value.strip()
                if current_subconf is None or current_subconf == subconf_name:
                    config[key] = value
            except:
                pass
        return config
        
