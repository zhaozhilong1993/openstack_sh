#!/bin/bash

yum install openstack-nova-api openstack-nova-cert \
  openstack-nova-conductor openstack-nova-console \
  openstack-nova-novncproxy openstack-nova-scheduler \
  python-novaclient -y
