from ifcb.db.bins2db import bins2db

from ifcb.io.path import Filesystem
from config import FS_ROOTS

fs = Filesystem(FS_ROOTS)

#for d in fs.all_days():
#    print d

#bins2db(fs,[])
bins2db(fs)
