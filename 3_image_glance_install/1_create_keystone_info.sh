#!/bin/bash

CONTROLLER_IP='10.0.0.10'
PASSWORD='stack'

# 1. create glance user
openstack user create --domain default --password ${PASSWORD} glance
# 2. binding role  
openstack role add --project service --user glance admin
# 3. create service
openstack service create --name glance  --description "OpenStack Image service" image

# 4. create endpoint
openstack endpoint create --region RegionOne image public http://${CONTROLLER_IP}:9292
openstack endpoint create --region RegionOne image internal http://${CONTROLLER_IP}:9292
openstack endpoint create --region RegionOne image admin http://${CONTROLLER_IP}:9292
