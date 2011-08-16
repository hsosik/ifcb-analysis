from functools import wraps

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