import numpy as np

from functools import reduce

def simple_prng(n,seed=1,shape=1):
    """This is a simple pseudo random number generator that is adequate
    for some purposes but is inferior to the algorithms provided
    by Python; it is used here so that the MATLAB and Python algorithms
    can generate the same random streams for operations requiring randomness
    n = maximum value (non-inclusive)
    shape = size of matrix to generate
    seed = random seed (default 1)
    """
    try:
        size = sum(shape)
    except TypeError:
        # allow shape to just be an integer
        shape = (shape,)
    size = reduce(lambda a,b:a*b,shape)
    out = np.zeros(size,dtype=int)
    prev = seed
    for j in range(size):
        out[j] = (prev * 30203) % 29663
        prev = out[j]
    # reshape in Fortran order, like MATLAB
    return (out % n).reshape(*shape,order='F')
