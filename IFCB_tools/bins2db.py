from ifcb.db.bins2db import bins2db

from ifcb.io.path import Filesystem
from config import FS_ROOTS

fs = Filesystem(FS_ROOTS)

bins2db(fs)