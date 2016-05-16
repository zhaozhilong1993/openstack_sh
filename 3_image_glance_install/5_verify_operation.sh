#!/bin/bash

export OS_IMAGE_API_VERSION=2

chown glance.glance -R /var/lib/glance
# wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
glance image-create --name "cirros"  --file cirros-0.3.4-x86_64-disk.img  --disk-format qcow2 --container-format bare  --visibility public --progress
glance image-list
