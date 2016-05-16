#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
RAMDON_KEY=`openssl rand -hex 10`
KEYSTONE_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. set the admin_token hash key
openstack-config --set   /etc/keystone/keystone.conf DEFAULT  admin_token ${RAMDON_KEY}

# 4. set database password
openstack-config --set /etc/keystone/keystone.conf database connection  mysql://keystone:${KEYSTONE_PASSWORD}@${CONTROLLER_IP}/keystone

# 5. set memcache addresss 
openstack-config --set /etc/keystone/keystone.conf memcache servers ${CONTROLLER_IP}:11211

# 6. set token
openstack-config --set /etc/keystone/keystone.conf token provider uuid 
openstack-config --set /etc/keystone/keystone.conf token driver memcache 

# 7. set revoke
openstack-config --set /etc/keystone/keystone.conf revoke driver sql

# 8. set memcache addresss 
openstack-config --set /etc/keystone/keystone.conf DEFAULT verbose True 
