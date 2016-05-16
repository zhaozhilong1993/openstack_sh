#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
GLANCE_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. set database password
openstack-config --set /etc/glance/glance-api.conf database connection  mysql://glance:${GLANCE_PASSWORD}@${CONTROLLER_IP}/glance

# 4. set glance-api
# 4.1 set keystone info
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_plugin password
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken project_domain_id default
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken user_domain_id default
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken project_name service
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken username glance 
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken password ${GLANCE_PASSWORD} 

# 4.2 
openstack-config --set /etc/glance/glance-api.conf paste_deploy flavor keystone

# 4.3 set store info
openstack-config --set /etc/glance/glance-api.conf glance_store default_store file
mkdir /var/lib/glance/images/
openstack-config --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir  /var/lib/glance/images/

# 4.4 set notification
openstack-config --set /etc/glance/glance-api.conf DEFAULT notification_driver noop
openstack-config --set /etc/glance/glance-api.conf DEFAULT verbose True 

# 5. set glance-registry
openstack-config --set /etc/glance/glance-registry.conf database connection  mysql://glance:${GLANCE_PASSWORD}@${CONTROLLER_IP}/glance
# 5.1 set keystone info
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_plugin password
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken project_domain_id default
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken user_domain_id default
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken project_name service
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken username glance
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken password ${GLANCE_PASSWORD} 

# 5.2
openstack-config --set /etc/glance/glance-registry.conf paste_deploy flavor keystone

# 5.3 set store info
openstack-config --set /etc/glance/glance-registry.conf glance_store default_store file
mkdir /var/lib/glance/images/
openstack-config --set /etc/glance/glance-registry.conf glance_store filesystem_store_datadir  /var/lib/glance/images/

# 5.4 set notification
openstack-config --set /etc/glance/glance-registry.conf DEFAULT notification_driver noop
openstack-config --set /etc/glance/glance-registry.conf DEFAULT verbose True

