#!/usr/bin/python

from gearman.client import GearmanClient

client = GearmanClient(['localhost'])

URL = 'http://ifcb-data.whoi.edu/feed.json'

client.submit_job('spider', URL)

