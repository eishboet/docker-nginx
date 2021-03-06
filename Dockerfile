FROM debian:buster-slim

# set version label
ARG BUILD_DATE="11042020"
ARG VERSION="1.0"
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# install nginx
RUN apt-get update \
	&& apt-get install -y nginx \
	&& echo "*** CONFIGURE NGINX ***" \
	&& apt-get clean \
	&& mkdir -p /config/{nginx,ssl,dhparam,log/nginx} /www \
	&& mv /etc/nginx/nginx.conf /config/nginx/nginx.conf \
	&& mv /etc/nginx/fastcgi_params /config/nginx/fastcgi_params \
	&& mv /etc/nginx/conf.d /config/conf.d \
	&& mv /etc/nginx/sites-enabled /config/nginx/sites-enabled \
	&& cp /var/www/html/* /www/ \
	&& ln -s /config/nginx/nginx.conf /etc/nginx/nginx.conf \
	&& ln -s /config/nginx/fastcgi_params /etc/nginx/fastcgi_params \
	&& ln -s /config/conf.d /etc/nginx/conf.d \
	&& ln -s /config/nginx/sites-enabled /etc/nginx/sites-enabled \
	&& ln -s /config/ssl /etc/nginx/ssl \
	&& ln -s /config/dhparam /etc/nginx/dhparam


VOLUME /config /www

# expose ports 80 and 443
EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", ""-g", "daemon off;"]
