#!/bin/bash


# 1. Replace ADMIN_TOKEN with the authentication token that you generated in the keystone.conf
ADMIN_TOKEN='ea9150990133fa0ef91c'
CONTROLLER_IP='10.0.0.10'
ADMIN_PASSWORD='stack'

# 2. Configure Token ,URL , API_VERSION
export OS_TOKEN=${ADMIN_TOKEN}
export OS_URL=http://${CONTROLLER_IP}:35357/v3
export OS_IDENTITY_API_VERSION=3

# 3. create admin project 
openstack project create --domain default --description "Admin Project" admin

# 4. create admin user
openstack user create --domain default --password ${ADMIN_PASSWORD} admin

# 5. create admin role
openstack role create admin

# 6. bind rol and project for admin user
openstack role add --project admin --user admin admin

# 7. create service project
openstack project create --domain default --description "Service Project" service

# 8. create demo project
openstack project create --domain default --description "Demo Project" demo

# 9. create demo user
openstack user create --domain default  --password ${ADMIN_PASSWORD} demo

# 10. create user role
openstack role create user

# 11. bind role and project for user
openstack role add --project demo --user demo user
