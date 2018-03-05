#!/bin/bash

yum -y install httpd
chkconfig httpd on
echo "Version $1"  >> /var/www/html/index.html
service httpd start
