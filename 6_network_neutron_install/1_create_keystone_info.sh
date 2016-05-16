#!/bin/bash

CONTROLLER_IP='10.0.0.10'
PASSWORD='stack'

# 1. create glance user
openstack user create --domain default --password ${PASSWORD} neutron 
# 2. binding role  
openstack role add --project service --user neutron admin
# 3. create service
openstack service create --name neutron  --description "OpenStack Networking" network 

# 4. create endpoint
openstack endpoint create --region RegionOne network public http://${CONTROLLER_IP}:9696
openstack endpoint create --region RegionOne network internal http://${CONTROLLER_IP}:9696
openstack endpoint create --region RegionOne network admin http://${CONTROLLER_IP}:9696
