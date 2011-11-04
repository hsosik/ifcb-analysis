from ifcb.io.path import Filesystem
import ifcb
import psycopg2 as pg
import datetime
import pytz

DEC2FLOAT = pg.extensions.new_type(
    pg.extensions.DECIMAL.values,
    'DEC2FLOAT',
    lambda value, curs: float(value) if value is not None else None)
pg.extensions.register_type(DEC2FLOAT)

FS_ROOTS = ['/Volumes/IFCB_onD', '/Volumes/J_IFCB/ifcb_data_MVCO_jun06']
PSQL_DB = 'ifcb'
PSQL_USER = 'jfutrelle'
PSQL_PASSWORD = '****'

fs = Filesystem(FS_ROOTS);

c = pg.connect('dbname=%s user=%s password=%s' % (PSQL_DB,PSQL_USER,PSQL_PASSWORD))
c.autocommit = True

db = c.cursor()

last_pid = None
for bin in fs.all_bins():
    ts = datetime.datetime(*bin.time[:6], tzinfo=pytz.timezone('UTC'))
    if bin.pid != last_pid:
        values = (ifcb.lid(bin.pid), ts, 'IFCB%s' % bin.instrument) 
        print 'inserting ' + str(values)
        db.execute('INSERT INTO bins (lid, ts, instrument) VALUES (%s, %s, %s)',values)
        last_pid = bin.pid
