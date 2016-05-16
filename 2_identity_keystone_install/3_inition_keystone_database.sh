#!/bin/bash

PASSWORD='stack'

# execute sql stat
mysql -uroot -p${PASSWORD} -e "
tee /tmp/keystone.log
drop database if exists keystone;
create database keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '${PASSWORD}';
quit"

# db_sync
keystone-manage db_sync
