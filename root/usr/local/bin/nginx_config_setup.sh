#!/bin/sh

set -e

# Create directories for nginx
mkdir -p /config/{nginx/sites-enabled,rules,conf.d,certs} \
mkdir -p /config/logs/{nginx,sites}  \

# copy default config files to the /config/nginx folder only if they do not exist
[[ ! -f /config/nginx/nginx.conf ]] \
  && cp /default/nginx.conf /config/nginx/nginx.conf
[[ ! -f /config/nginx/fastcgi.conf ]] \
  && cp /default/fastcgi.conf /config/nginx/fastcgi.conf
[[ ! -f /config/nginx/fastcgi_params ]] \
  && cp /default/fastcgi_params /config/nginx/fastcgi_params
[[ ! -f /config/nginx/sites-enabled/default ]] \
  && cp /default/default /config/nginx/sites-enabled/default
[[ $(find /www -type f | wc -l) -eq 0 ]] \
  && cp /default/index.html /www/index.html

# set ownership and permissions
chmod -R g+w /config/nginx /www
chmod -R 644 /etc/logrotate.d

exec "nginx -c /config/nginx.conf -g 'daemon off'"
