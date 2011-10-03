from ifcb.io.convert import fs2atom, fs2json_feed, fs2html_feed, fs2rss, bin2csv
from ifcb.io.path import Filesystem
from config import FS_ROOTS, FEED
import time
import re

if __name__=='__main__':
    #dates = r'2007-11-01T00:29:00Z'
    #date = time.strptime(re.sub('Z$','UTC',dates),'%Y-%m-%dT%H:%M:%S%Z')
    bin = Filesystem(FS_ROOTS).resolve('http://ifcb-data.whoi.edu/IFCB1_2011_270_193351')
    bin2csv(bin)