#!/bin/bash

CONTROLLER_IP='10.0.0.10'
PASSWORD='stack'

# 1. create glance user
openstack user create --domain default --password ${PASSWORD} nova 
# 2. binding role  
openstack role add --project service --user nova admin
# 3. create service
openstack service create --name nova  --description "OpenStack Compute" compute 

# 4. create endpoint
openstack endpoint create --region RegionOne compute public http://${CONTROLLER_IP}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://${CONTROLLER_IP}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://${CONTROLLER_IP}:8774/v2/%\(tenant_id\)s

