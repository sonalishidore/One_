#!/bin/bash
clear;
echo 'Wellcome to nginx page speed install script';
sleep 2;

#update system
echo 'Update the system first';
sleep 2;
sudo apt-get update ;
sudo apt-get -y upgrade;

#install dependencies
echo 'Install dependencies';
sleep 2;
sudo apt-get -y --force-yes  install build-essential zlib1g-dev libpcre3 libpcre3-dev unzip apache2-utils;

#download ngx_pagespeed
cd;
NPS_VERSION=1.9.32.10;

echo 'download ngx_pagespeed';
sleep 2;
wget  https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip;

echo 'unzip ngx_pagespeed'
sleep 2;
unzip -o release-${NPS_VERSION}-beta.zip;

cd ngx_pagespeed-release-${NPS_VERSION}-beta/
echo 'download psol';
sleep 2;
wget   https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz;

echo 'unpack psol'
sleep 2;
tar -xzvf ${NPS_VERSION}.tar.gz;

#Download and build nginx with support for pagespeed
cd;
NGINX_VERSION=1.8.0;
echo 'download ngix source'
sleep 2;
wget  http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz;

echo 'unpack ngix source'
sleep 2;
tar -xvzf nginx-${NGINX_VERSION}.tar.gz;

cd nginx-${NGINX_VERSION}/
echo 'Configure'
sleep 2;
./configure --add-module=$HOME/ngx_pagespeed-release-${NPS_VERSION}-beta --with-http_stub_status_module;

echo 'Make';
sleep 2;
make;

echo 'Install';
sleep 2;
sudo make install;

#make and configure directories
#sudo mkdir -p /var/ngx_pagespeed_cache/;
#sudo chown -R nobody:nogroup /var/ngx_pagespeed_cache;

#sudo mkdir -p /var/log/pagespeed;
#sudo chown -R nobody:nogroup /var/log/pagespeed;

#create admin password for pagespeed statistics
echo "Create password for nginx page speed admin pages"
sudo htpasswd -c /usr/local/nginx/conf/.htpasswd admin;
clear;

#dowload and copy nginx.conf
sudo mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.default
wget https://gist.githubusercontent.com/Dryam/ec9eb3b96a34f6904785/raw/41de5cf70ce2b92477440a5b2e8389f773db8a7c/nginx.conf;
sudo cp nginx.conf /usr/local/nginx/conf/nginx.conf

#Download and set up init scripts
echo '#Download and set up init scripts';
sudo wget   https://raw.githubusercontent.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx;
sudo chmod +x /etc/init.d/nginx;
sudo update-rc.d -f nginx defaults;
sudo service nginx start;
sleep 2;
sudo service nginx status;

echo 'Complete';
