#!/bin/bash

yum install openstack-keystone httpd mod_wsgi  memcached python-memcached -y
systemctl enable memcached.service
systemctl start memcached.service
