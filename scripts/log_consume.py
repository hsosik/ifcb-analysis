from pika import BlockingConnection, ConnectionParameters
import blobfix
import re
from sys import argv

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

q=argv[1]

c.queue_declare(queue=q)

def callback(ch, method, properties, body):
    print body
    ch.basic_ack(delivery_tag = method.delivery_tag)

c.basic_consume(callback, queue=q)

c.start_consuming()
