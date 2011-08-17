from ifcb.io.dir import YearsDir, DayDir

class Filesystem:
    years_dirs = []
    
    def __init__(self,years_dirs):
        years_dirs = [YearsDir[d] for d in years_dirs]

    def all_days(self):
        for years in years_dirs:
            for day in years:
                yield day
                
    def all_bins(self):
        for day in self.all_days():
            for bin in day:
                yield bin
    
    def all_targets(self):
        for bin in self.all_bins():
            for target in bin:
                yield target
                
    # TODO way of finding bins within a given time range
            