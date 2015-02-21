#!/bin/bash
SOURCE_SUBNET=108.56.73.253/24
HOSTNAME=reverb
HTTP_PORT=8888

apt-get update -y
apt-get upgrade -y

apt-get install squid -y
cd /etc/squid3/
mv squid.conf squid.conf.original

echo "
http_port $HTTP_PORT
visible_hostname $HOSTNAME
acl ALLOWED src $SOURCE_SUBNET
http_access allow ALLOWED
forwarded_for off
" > /etc/squid3/squid.conf

service squid restart

echo "Ready to proxy for $SOURCE_SUBNET on port $HTTP_PORT"
