from pika import BlockingConnection, ConnectionParameters
from sys import argv
import blobfix

conn = BlockingConnection(ConnectionParameters('localhost'))
c = conn.channel()

c.queue_declare(queue=blobfix.QUEUE)

queue = blobfix.QUEUE
message = ' '.join(argv[1:])

print 'enqueueing %s...' % (message)

c.basic_publish(exchange='', routing_key=queue, body=message)

conn.close()
