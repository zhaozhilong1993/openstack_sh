#!/bin/bash

# 1. install yum.repo for openstack-liberty
#yum install centos-release-openstack-liberty
#yum install https://rdoproject.org/repos/openstack-liberty/rdo-release-liberty.rpm

# 2. Upgrade the packages
yum upgrade -y

# 3. Install the OpenStack client
yum install python-openstackclient -y

# 4. install selinux support 
yum install openstack-selinux -y

# =================================================================
#
# 5. installl database , ntp
yum install mariadb-server ntp -y

# 5.1 start mariadb
systemctl restart mariadb
systemctl enable mariadb
# 5.1.1 configuration mysql
mysql_secure_installation

# 5.2 start ntp
systemctl restart ntpd 
systemctl enable ntpd
