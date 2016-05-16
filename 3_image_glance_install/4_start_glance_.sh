#!/bin/bash

chown glance.glance -R /var/log/glance
systemctl enable openstack-glance-api.service openstack-glance-registry.service
systemctl restart openstack-glance-api.service openstack-glance-registry.service
