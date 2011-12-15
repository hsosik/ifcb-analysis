from ifcb.io.path import Filesystem
import ifcb
import psycopg2 as psql
import datetime
import pytz
from config import PSQL_CONNECT
from ifcb.util import log_msg, sha1_file
import os
from time import time

def fixity(db,bin):
    lid = bin.lid
    db.execute("select count(*) from fixity where lid = %s",(lid,)) # dangling comma is necessary
    count = db.fetchone()[0]
    if count==0:
        log_msg('computing message digests...')
        paths = {'roi': bin.roi_path, 'hdr': bin.hdr_path }
        adc_path = bin.adc_path
        raw_adc_path = bin.raw_adc_path
        if adc_path != raw_adc_path:
            paths['adc'] = raw_adc_path
            paths['mod'] = adc_path
        else:
            paths['adc'] = adc_path
        for filetype, local_path in paths.items():
            filename = os.path.basename(local_path)
            length = os.stat(local_path).st_size
            fix_time = int(time())
            sha1 = sha1_file(local_path)
            values = (lid,length,filename,filetype,sha1,fix_time,local_path)
            log_msg('inserting fixity record ' + str(values))
            db.execute("insert into fixity (lid, length, filename, filetype, sha1, fix_time, local_path) values (%s,%s,%s,%s,%s,%s::abstime::timestamp with time zone at time zone 'GMT',%s)",values)

def timestamp(db,bin):
    db.execute("select count(*) from bins where lid = %s",(bin.lid,)) # dangling comma is necessary
    count = db.fetchone()[0]
    if count == 0:
        ts = datetime.datetime(*bin.time[:6], tzinfo=pytz.timezone('UTC'))
        values = (bin.lid, ts)
        log_msg('inserting timestamped record ' + str(values))
        db.execute('INSERT INTO bins (lid, sample_time) VALUES (%s, %s)',values)

def bins2db(resolver,skip_years=[2006,2007,2008,2009,2010]):
    log_msg('connecting to postgresql...')
    c = psql.connect(PSQL_CONNECT)
    db = c.cursor()

    log_msg('listing all bins...')
    for day in resolver.all_days():
        if not day.time.tm_year in skip_years:
            log_msg('listing %s...' % day)
            for bin in day:
                fixity(db,bin)
                timestamp(db,bin)
            c.commit()
    log_msg('done')
        
