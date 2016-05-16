#!/bin/bash

systemctl restart openstack-nova-api.service

systemctl enable neutron-server.service \
  neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
   neutron-metadata-agent.service

systemctl restart neutron-server.service \
  neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
  neutron-metadata-agent.service

systemctl enable neutron-l3-agent.service
systemctl restart neutron-l3-agent.service
