#!/bin/bash

CONTROLLER_IP='10.0.0.10'


#  1. check admin user
openstack --os-auth-url http://${CONTROLLER_IP}:35357/v3 \
  --os-project-domain-id default --os-user-domain-id default \
  --os-project-name admin --os-username admin --os-auth-type password \
  token issue

# 2. check demo user
openstack --os-auth-url http://${CONTROLLER_IP}:5000/v3 \
  --os-project-domain-id default --os-user-domain-id default \
  --os-project-name demo --os-username demo --os-auth-type password \
  token issue
