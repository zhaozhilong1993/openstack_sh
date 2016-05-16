#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='openstack'
NOVA_PASSWORD='openstack'
RABBIT_PASSWORD='openstack'
CONTROLLER_IP='192.168.0.2'

# 3. set nova
openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone
# 3.1 set keystone info
openstack-config --set /etc/nova/nova.conf neutron url http://${CONTROLLER_IP}:9696 
openstack-config --set /etc/nova/nova.conf neutron auth_url http://${CONTROLLER_IP}:35357 
openstack-config --set /etc/nova/nova.conf neutron auth_plugin password
openstack-config --set /etc/nova/nova.conf neutron project_domain_id default
openstack-config --set /etc/nova/nova.conf neutron user_domain_id default
openstack-config --set /etc/nova/nova.conf neutron region_name RegionOne 
openstack-config --set /etc/nova/nova.conf neutron project_name service
openstack-config --set /etc/nova/nova.conf neutron username neutron
openstack-config --set /etc/nova/nova.conf neutron password ${NEUTRON_PASSWORD}
