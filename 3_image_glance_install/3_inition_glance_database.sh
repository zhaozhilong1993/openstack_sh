#!/bin/bash

PASSWORD='stack'

# execute sql stat
mysql -uroot -pstack -e "
tee /tmp/glance.log
drop database if exists glance;
create database glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY '${PASSWORD}';
quit"

# db_sync
glance-manage db_sync
