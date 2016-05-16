#!/bin/bash

DATABASE="nova"
DATABASE_USER="nova"
USER_PASSWORD="stack"
ROOT_PASSWORD="stack"

# execute sql stat
mysql -uroot -p${ROOT_PASSWORD} -e "
tee /tmp/glance.log
drop database if exists ${DATABASE};
create database ${DATABASE};
GRANT ALL PRIVILEGES ON ${DATABASE_USER}.* TO '${DATABASE_USER}'@'localhost' IDENTIFIED BY '${USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_USER}.* TO '${DATABASE_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}';
quit"

# db_sync
nova-manage db sync
