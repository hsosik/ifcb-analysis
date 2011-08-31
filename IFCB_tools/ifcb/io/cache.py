import sys
import config
import pylibmc
import io
from array import array
import pickle

if config.USE_MEMCACHED:
    cache = pylibmc.Client(config.MEMCACHED_SERVERS, binary=True)

# cache_key the cache key of the desired object
# f a function of one argument, an output stream, that generates the object
# out where to write the value (cached or not)
def cache_io(cache_key,f,out=sys.stdout):
    if config.USE_MEMCACHED:
        bytes = cache.get(cache_key)
        if bytes is None: # cache miss
            buffer = io.BytesIO()
            f(buffer)
            bytes = buffer.getvalue()
            try:
                cache.add(cache_key,bytes)
            except pylibmc.Error:
                # do nothing
                noop = None
        array('B',bytes).tofile(out)
    else:
        f(out)
        
# cache_key the key
# f a function of no arguments returning the object
def cache_obj(cache_key,f):
    if config.USE_MEMCACHED:
        cache = pylibmc.Client(config.MEMCACHED_SERVERS, binary=True)
        bytes = cache.get(cache_key)
        obj = None
        if bytes is None: # cache miss
            obj = f()
            bytes = pickle.dumps(obj,2)
            try:
                cache.add(cache_key,bytes)
            except pylibmc.Error:
                # do nothing
                noop = None
            return obj
        else:
            return pickle.loads(bytes)
    else:
        return f()
            
