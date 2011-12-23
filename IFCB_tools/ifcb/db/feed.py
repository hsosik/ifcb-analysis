import psycopg2 as psql
import datetime
import pytz
from config import PSQL_CONNECT
import ifcb
from ifcb.util import log_msg, utcdatetime
import time

def latest_bins(n=25,date=None):
    if date is None:
        date = time.gmtime()
    dt = utcdatetime(date)
    c = psql.connect(PSQL_CONNECT)
    db = c.cursor()
    db.execute("select lid,sample_time from bins where sample_time <= %s order by sample_time desc limit %s",(dt,n)) # dangling comma is necessary
    for row in db.fetchall():
        yield ifcb.pid(row[0])

def day_bins(date=None):
    if date is None:
        date = time.gmtime()
    dt = utcdatetime(date)
    c = psql.connect(PSQL_CONNECT)
    db = c.cursor()
    db.execute("set session time zone 'UTC'")
    db.execute("select lid,sample_time from bins where date_part('year',sample_time) = %s and date_part('month',sample_time) = %s and date_part('day',sample_time) = %s order by sample_time desc",(dt.year,dt.month,dt.day))
    for row in db.fetchall():
        yield ifcb.pid(row[0])

