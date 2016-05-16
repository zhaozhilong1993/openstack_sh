#!/bin/bash

systemctl enable httpd.service memcached.service
systemctl restart httpd.service memcached.service
