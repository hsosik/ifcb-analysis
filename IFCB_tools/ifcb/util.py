from functools import wraps
import re
import string

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
    
    