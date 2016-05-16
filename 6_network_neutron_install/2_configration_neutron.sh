#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='stack'
NOVA_PASSWORD='stack'
RABBIT_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. set database password
openstack-config --set /etc/neutron/neutron.conf database connection  mysql://neutron:${NEUTRON_PASSWORD}@${CONTROLLER_IP}/neutron

# 4. set neutron
openstack-config --set /etc/neutron/neutron.conf DEFAULT auth_strategy keystone
# 4.1 set keystone info
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken auth_plugin password
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken project_domain_id default
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken user_domain_id default
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken project_name service
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken username neutron
openstack-config --set /etc/neutron/neutron.conf keystone_authtoken password ${NEUTRON_PASSWORD} 

# 5. set rabbitmq
openstack-config --set /etc/neutron/neutron.conf DEFAULT rpc_backend rabbit

# 6. set oslo_messaging_rabbit
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_host ${CONTROLLER_IP}
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_userid  openstack
openstack-config --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_password ${RABBIT_PASSWORD}

# 7. enable ML2
openstack-config --set /etc/neutron/neutron.conf DEFAULT core_plugin ml2
openstack-config --set /etc/neutron/neutron.conf DEFAULT service_plugins router
openstack-config --set /etc/neutron/neutron.conf DEFAULT allow_overlapping_ips True

# 8. configure Networking to notify Compute of network topology changes
openstack-config --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_status_changes True
openstack-config --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_data_changes True
openstack-config --set /etc/neutron/neutron.conf DEFAULT nova_url http://${CONTROLLER_IP}:8774/v2

openstack-config --set /etc/neutron/neutron.conf nova auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/neutron/neutron.conf nova auth_plugin password
openstack-config --set /etc/neutron/neutron.conf nova project_domain_id default
openstack-config --set /etc/neutron/neutron.conf nova user_domain_id default
openstack-config --set /etc/neutron/neutron.conf nova region_name RegionOne
openstack-config --set /etc/neutron/neutron.conf nova project_name service 
openstack-config --set /etc/neutron/neutron.conf nova username nova
openstack-config --set /etc/neutron/neutron.conf nova password ${NOVA_PASSWORD}

# 9. set the lock path
openstack-config --set /etc/neutron/neutron.conf oslo_concurrency lock_path /var/lib/neutron/tmp

# 10. open verbose
openstack-config --set /etc/neutron/neutron.conf DEFAULT verbose True


