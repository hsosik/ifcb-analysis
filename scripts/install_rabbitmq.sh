#!/bin/sh
# for stock debian x64
curl -O http://www.rabbitmq.com/releases/rabbitmq-server/v2.7.1/rabbitmq-server_2.7.1-1_all.deb
apt-get install erlang-nox python-pip
dpkg -i rabbitmq-server_2.7.1-1_all.deb
pip install pika

