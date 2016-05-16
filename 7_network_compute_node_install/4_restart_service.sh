#!/bin/bash

systemctl restart openstack-nova-compute.service
systemctl enable neutron-linuxbridge-agent.service
systemctl restart neutron-linuxbridge-agent.service
