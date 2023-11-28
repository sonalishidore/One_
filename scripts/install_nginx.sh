#!/bin/bash

sudo yum update
sudo amazon-linux-extras install nginx1
sudo rm /etc/nginx/sites-enabled/default
sudo vi /etc/nginx/sites-enabled/default
