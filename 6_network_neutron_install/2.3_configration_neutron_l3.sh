#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion


# 3. Configure the layer-3 agent
openstack-config --set /etc/neutron/l3_agent.ini DEFAULT interface_driver  neutron.agent.linux.interface.BridgeInterfaceDriver
openstack-config --set /etc/neutron/l3_agent.ini DEFAULT external_network_bridge  
 
# 4. open verbos
openstack-config --set /etc/neutron/l3_agent.ini DEFAULT verbose True
