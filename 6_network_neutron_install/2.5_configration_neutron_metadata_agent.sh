#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'
METADATA_SECRET='neutron'

# 3. set neutron
openstack-config --set /etc/neutron/metadata_agent.ini DEFAULT auth_strategy keystone
# 3.1 set keystone info
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken auth_plugin password
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken project_domain_id default
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken user_domain_id default
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken project_name service
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken username neutron 
openstack-config --set /etc/neutron/metadata_agent.ini keystone_authtoken password ${NEUTRON_PASSWORD} 


openstack-config --set /etc/neutron/metadata_agent.ini DEFAULT nova_metadata_ip ${CONTROLLER_IP}
openstack-config --set /etc/neutron/metadata_agent.ini DEFAULT metadata_proxy_shared_secret ${METADATA_SECRET}
openstack-config --set /etc/neutron/metadata_agent.ini DEFAULT verbose True
