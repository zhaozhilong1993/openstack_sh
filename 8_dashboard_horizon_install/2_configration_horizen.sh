#!/bin/bash

# 3. use vim to change /etc/openstack-dashboard/local_settings
OPENSTACK_HOST = "controller_ip"
ALLOWED_HOSTS = ['*',]

CACHES = {
    'default': {
         'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
         'LOCATION': '127.0.0.1:11211',
    }
}

OPENSTACK_KEYSTONE_DEFAULT_ROLE = "user"

OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True

OPENSTACK_API_VERSIONS = {
    "identity": 3,
    "volume": 2,
}
