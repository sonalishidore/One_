 #!/bin/bash
 sudo yum update -
 sudo update install nginx1 -y
 sudo systemctl start nginx && sudo systemctl enable nginx
 sudo systemctl status nginx
 nano /etc/nginx/sites-available/default
 server {
        listen 80 default_server;
        #listen [::]:80 default_server;
        }
  sudo ln -s /etc/nginx/sites-available/websitename /etc/nginx/sites-enabled
  nginx -t
  sudo systemctl restart nginx
 
