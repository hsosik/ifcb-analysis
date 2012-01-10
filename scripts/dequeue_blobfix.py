from pika import BlockingConnection, ConnectionParameters
from random import random
import blobfix
import re

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

c.queue_declare(queue=blobfix.QUEUE)
c.queue_declare(queue=blobfix.LOG_QUEUE)
c.queue_declare(queue=blobfix.FAIL_QUEUE)

def callback(ch, method, properties, body):
    try:
        lid = re.match(r'.*(IFCB.*).zip',body).groups()[0]
        msg = blobfix.fix(lid,skip=True)
        c.basic_publish(exchange='', routing_key=blobfix.LOG_QUEUE, body=msg)
        ch.basic_ack(delivery_tag = method.delivery_tag)
    except:
        c.basic_publish(exchange='', routing_key=blobfix.FAIL_QUEUE, body=body)
        ch.basic_ack(delivery_tag = method.delivery_tag)

c.basic_consume(callback, queue=blobfix.QUEUE)
c.basic_qos(prefetch_count=1)

c.start_consuming()
