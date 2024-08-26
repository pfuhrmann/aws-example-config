#!/bin/bash

# Install and start Apache web server
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create a simple index.html file with the private IP address of the EC2 instance
META_TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: ${META_TOKEN}" http://169.254.169.254/latest/meta-data/local-ipv4`
echo "${PRIVATE_IP}" > /var/www/html/index.html
