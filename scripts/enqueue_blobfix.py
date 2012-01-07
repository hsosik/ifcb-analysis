from pika import BlockingConnection, ConnectionParameters
from sys import argv
import blobfix

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

c.queue_declare(queue=blobfix.QUEUE)

lid = argv[1]

print 'enqueueing %s...' % (lid)

c.basic_publish(exchange='', routing_key=blobfix.QUEUE, body=lid)

conn.close()
