#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NEUTRON_PASSWORD='stack'
NOVA_PASSWORD='stack'
RABBIT_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. Configure the Modular Layer 2 (ML2) plug-in
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2 type_drivers flat,vlan,vxlan
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2 tenant_network_types vxlan
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2 mechanism_drivers linuxbridge,l2population
 
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2 extension_drivers port_security 
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_flat flat_networks public 
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_vxlan vni_ranges 1:1000
openstack-config --set  /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup enable_ipset True

ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
