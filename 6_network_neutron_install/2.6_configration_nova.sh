#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'
METADATA_SECRET='neutron'

# 4. set nova
openstack-config --set /etc/nova/nova.conf neutron url http://${CONTROLLER_IP}:9696 
openstack-config --set /etc/nova/nova.conf neutron auth_url http://${CONTROLLER_IP}:35357 
openstack-config --set /etc/nova/nova.conf neutron auth_plugin password  
openstack-config --set /etc/nova/nova.conf neutron project_domain_id default
openstack-config --set /etc/nova/nova.conf neutron user_domain_id default
openstack-config --set /etc/nova/nova.conf neutron region_name RegionOne 
openstack-config --set /etc/nova/nova.conf neutron project_name service 
openstack-config --set /etc/nova/nova.conf neutron username neutron 
openstack-config --set /etc/nova/nova.conf neutron password ${NEUTRON_PASSWORD} 
openstack-config --set /etc/nova/nova.conf neutron service_metadata_proxy True
openstack-config --set /etc/nova/nova.conf neutron metadata_proxy_shared_secret ${METADATA_SECRET}
