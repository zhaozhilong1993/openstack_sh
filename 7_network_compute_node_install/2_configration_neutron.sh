#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='stack'
NOVA_PASSWORD='stack'
RABBIT_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. set neutron
openstack-config --set /etc/neutron/neutron.conf DEFAULT auth_strategy keystone
# 3.1 set keystone info
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_plugin password
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken project_domain_id default
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken user_domain_id default
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken project_name service
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken username neutron
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken password ${NEUTRON_PASSWORD}

# 4. set rabbitmq
openstack-config --set /etc/neutron/neutron.conf DEFAULT rpc_backend rabbit

# 5. set oslo_messaging_rabbit
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_host ${CONTROLLER_IP}
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_userid  openstack
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_password ${RABBIT_PASSWORD}

openstack-config --set /etc/neutron/neutron.conf oslo_concurrency lock_path /var/lib/neutron/tmp
openstack-config --set /etc/neutron/neutron.conf DEFAULT verbose True
