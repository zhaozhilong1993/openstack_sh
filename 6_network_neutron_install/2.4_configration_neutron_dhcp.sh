#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion


# 3. Configure the layer-3 agent
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver neutron.agent.linux.interface.BridgeInterfaceDriver
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_driver neutron.agent.linux.dhcp.Dnsmasq 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT enable_isolated_metadata True

# 4. open verbose
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT verbose True 

# 5. enable the dnsmasq configuration file 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT dnsmasq_config_file /etc/neutron/dnsmasq-neutron.conf

# 6. Create and edit the /etc/neutron/dnsmasq-neutron.conf file 
echo 'dhcp-option-force=26,1450' > /etc/neutron/dnsmasq-neutron.conf
