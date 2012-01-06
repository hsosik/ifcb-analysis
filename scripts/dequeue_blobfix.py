from pika import BlockingConnection, ConnectionParameters
from random import random
import blobfix
import re

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

c.queue_declare(queue=blobfix.QUEUE)

def callback(ch, method, properties, body):
    lid = re.match(r'.*(IFCB.*).zip',body).groups()[0]
    print 'fixing ' + lid + '...'
    blobfix.fix(lid)
    ch.basic_ack(delivery_tag = method.delivery_tag)

c.basic_consume(callback, queue=blobfix.QUEUE)
c.basic_qos(prefetch_count=1)

c.start_consuming()
