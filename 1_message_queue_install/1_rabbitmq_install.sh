#!/bin/bash

# 1. install rabbitmq
yum install rabbitmq-server -y

# 2. start rabbitmq 
systemctl restart rabbitmq-server.service
systemctl enable rabbitmq-server.service

# 3. confige rabbitmq -- add openstack user
rabbitmqctl add_user openstack stack

# 4. permit configuration
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
