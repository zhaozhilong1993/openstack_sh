#!/bin/bash

# 1. install openstac-config command
yum install openstack-utils -y

# 2. set global settion
NOVA_PASSWORD='stack'
RABBIT_PASSWORD='stack'
CONTROLLER_IP='10.0.0.10'

# 3. set database password
openstack-config --set /etc/nova/nova.conf database connection  mysql://nova:${NOVA_PASSWORD}@${CONTROLLER_IP}/nova

# 4. set nova
openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone 
# 4.1 set keystone info
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_uri http://${CONTROLLER_IP}:5000
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_url http://${CONTROLLER_IP}:35357
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_plugin password
openstack-config --set /etc/nova/nova.conf keystone_authtoken project_domain_id default
openstack-config --set /etc/nova/nova.conf keystone_authtoken user_domain_id default
openstack-config --set /etc/nova/nova.conf keystone_authtoken project_name service
openstack-config --set /etc/nova/nova.conf keystone_authtoken username nova
openstack-config --set /etc/nova/nova.conf keystone_authtoken password ${NOVA_PASSWORD} 


# 5. set rabbitmq
openstack-config --set /etc/nova/nova.conf DEFAULT rpc_backend rabbit

# 6. set oslo_messaging_rabbit
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_host ${CONTROLLER_IP}
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_userid  openstack
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_password ${RABBIT_PASSWORD}

# 7. set the contorller node ip
openstack-config --set /etc/nova/nova.conf DEFAULT my_ip ${CONTROLLER_IP}
openstack-config --set /etc/nova/nova.conf DEFAULT network_api_class nova.network.neutronv2.api.API
openstack-config --set /etc/nova/nova.conf DEFAULT security_group_api neutron 
openstack-config --set /etc/nova/nova.conf DEFAULT linuxnet_interface_driver nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
openstack-config --set /etc/nova/nova.conf DEFAULT firewall_driver nova.virt.firewall.NoopFirewallDriver

# 8. set vnc connect
openstack-config --set /etc/nova/nova.conf vnc vncserver_listen ${CONTROLLER_IP}
openstack-config --set /etc/nova/nova.conf vnc vncserver_proxyclient_address ${CONTROLLER_IP}

# 9. set glance address
openstack-config --set /etc/nova/nova.conf glance host ${CONTROLLER_IP}

# 10. set oslo_concurrency
openstack-config --set /etc/nova/nova.conf oslo_concurrency lock_path /var/lib/nova/tmp

# 11. disbale EC2 API
openstack-config --set /etc/nova/nova.conf DEFAULT enabled_apis osapi_compute,metadata

# 12. open verbose
openstack-config --set /etc/nova/nova.conf DEFAULT verbose True
