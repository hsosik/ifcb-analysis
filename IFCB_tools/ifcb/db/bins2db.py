from ifcb.io.path import Filesystem
import ifcb
import psycopg2 as psql
import datetime
import pytz
from config import PSQL_CONNECT
from ifcb.util import log_msg

def bins2db(resolver,skip_years=[2006,2007,2008,2009,2010]):
    log_msg('connecting to postgresql...')
    c = psql.connect(PSQL_CONNECT)
    db = c.cursor()

    log_msg('listing all bins...')
    for day in resolver.all_days():
        if not day.time.tm_year in skip_years:
            log_msg('listing %s...' % day)
            for bin in day:
                lid = ifcb.lid(bin.pid)
                ts = datetime.datetime(*bin.time[:6], tzinfo=pytz.timezone('UTC'))
                db.execute("select count(*) from bins where lid = %s",(lid,)) # dsngling comma is necessary
                count = db.fetchone()[0]
                if count > 0:
                    #log_msg('skipping %s...' % bin)
                    pass
                else:
                    values = (lid, ts)
                    log_msg('inserting ' + str(values))
                    db.execute('INSERT INTO bins (lid, sample_time) VALUES (%s, %s)',values)
            c.commit()
    log_msg('done')
        
