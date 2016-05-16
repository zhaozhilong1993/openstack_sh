#!/bin/bash

# 1. Replace ADMIN_TOKEN with the authentication token that you generated in the keystone.conf
ADMIN_TOKEN='ea9150990133fa0ef91c'
CONTROLLER_IP='10.0.0.10'

# 2. Configure Token ,URL , API_VERSION
export OS_TOKEN=${ADMIN_TOKEN}
export OS_URL=http://${CONTROLLER_IP}:35357/v3
export OS_IDENTITY_API_VERSION=3

# 3. create service
openstack service create --name keystone --description "OpenStack Identity" identity

# 4. create endpoint
openstack endpoint create --region RegionOne identity public http://${CONTROLLER_IP}:5000/v2.0
openstack endpoint create --region RegionOne identity internal http://${CONTROLLER_IP}:5000/v2.0
openstack endpoint create --region RegionOne identity admin http://${CONTROLLER_IP}:35357/v2.0

