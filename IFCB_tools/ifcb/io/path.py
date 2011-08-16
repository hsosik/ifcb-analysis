import ifcb.io.dir

class Filesystem:
    years_dirs = []
    
    def __init__(self,years_dirs):
        years_dirs = [YearsDir[d] for d in years_dirs]

    # TODO all bins
    # TODO way of finding bins within a given time range
            