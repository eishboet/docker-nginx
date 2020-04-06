Nginx is a simple webserver with php support. 

Easy user customerisation can be made through the config files located in the /config directory. The default configuration is set to serve pages located in the /www directory, though you can easily switch this to /var/www/html via the "default" config file located in /config/nginx/sites-enabled.

Nginx access and error logs are saved to the /config/nginx/logs/nginx directory. Site specific logging can be achieved by declaring an access and error log within the "default" config file located in /config/nginx/sites-enabled directory.

Code based largely on linuxserver/docker-nginx.
