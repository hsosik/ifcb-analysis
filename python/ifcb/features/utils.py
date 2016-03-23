import time
from functools import wraps
from functools import partial
from types import GeneratorType

# from http://stackoverflow.com/questions/653368/how-to-create-a-python-decorator-that-can-be-used-either-with-or-without-paramet
def doublewrap(f):
    '''
    a decorator decorator, allowing the decorator to be used as:
    @decorator(with, arguments, and=kwargs)
    or
    @decorator
    '''
    @wraps(f)
    def new_dec(*args, **kwargs):
        if len(args) == 1 and len(kwargs) == 0 and callable(args[0]):
            # actual decorated function
            return f(args[0])
        else:
            # decorator arguments
            return lambda realf: f(realf, *args, **kwargs)
    return new_dec

@doublewrap
def memoize(fn,ttl=31557600,ignore_exceptions=False,key=None):
    """decorator to memoize a function by its args,
    with an expiration time. use this to wrap an idempotent
    or otherwise cacheable getter or transformation function.
    the function args must be hashable.
    ignore exceptions means not to expire values in the case
    that the function to generate them raises an exception.
    if a generator is received, silently applies list() to it.
    be very careful about memoizing generator functions as this
    may not be desired"""
    cache = {}
    exp = {}
    @wraps(fn)
    def inner(*args,**kw):
        now = time.time()
        if key is not None:
            args_key = key(args)
        else:
            args_key = args
        if args_key not in exp or now > exp[args_key] or args_key not in cache:
            try:
                new_value = fn(*args,**kw)
            except:
                if ignore_exceptions and args_key in cache:
                    new_value = cache[args_key]
                else:
                    raise
            # we've got a value to cache, but it's a generator; freeze it
            if isinstance(new_value, GeneratorType):
                new_value = list(new_value)
            cache[args_key] = new_value
            exp[args_key] = now + ttl
        return cache[args_key]
    return inner

class imemoize(object):
    """cache the return value of a method
    
    This class is meant to be used as a decorator of methods. The return value
    from a given method invocation will be cached on the instance whose method
    was invoked. All arguments passed to a method decorated with memoize must
    be hashable.
    
    If a memoized method is invoked directly on its class the result will not
    be cached. Instead the method will be invoked like a static method:
    class Obj(object):
        @memoize
        def add_to(self, arg):
            return self + arg
    Obj.add_to(1) # not enough arguments
    Obj.add_to(1, 2) # returns 3, result is not cached
    """
    def __init__(self, func):
        self.func = func
    def __get__(self, obj, objtype=None):
        if obj is None:
            return self.func
        return partial(self, obj)
    def __call__(self, *args, **kw):
        obj = args[0]
        try:
            cache = obj.__cache
        except AttributeError:
            cache = obj.__cache = {}
        key = (self.func, args[1:], frozenset(kw.items()))
        try:
            res = cache[key]
        except KeyError:
            res = cache[key] = self.func(*args, **kw)
        return res
