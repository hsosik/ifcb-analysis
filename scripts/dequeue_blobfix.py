from pika import BlockingConnection, ConnectionParameters
from random import random
import blobfix

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

c.queue_declare(queue=blobfix.QUEUE)

def callback(ch, method, properties, body):
    lid = body
    blobfix.fix(lid)
    ch.basic_ack(delivery_tag = method.delivery_tag)

c.basic_consume(callback, queue=blobfix.QUEUE)
c.basic_qos(prefetch_count=1)

c.start_consuming()
