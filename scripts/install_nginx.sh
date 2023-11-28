#!/bin/bash

# Update the system
sudo yum update -y

# Install NGINX
sudo yum install nginx -y

# Enable NGINX to start on boot
sudo systemctl enable nginx

# Start NGINX
sudo systemctl start nginx
