FROM debian:buster-slim

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# copy local directories and files
COPY root/ /

# install nginx
RUN apt-get update \
	&& apt-get install -y nginx \
	&& echo "*** CONFIGURE NGINX ***" \
	&& rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d /etc/nginx/sites-available /etc/nginx/fastcgi_params /etc/nginx/fastcgi.conf \
	&& apt-get clean \
	&& chmod +x /usr/local/sbin/nginx_config_setup.sh

VOLUME /config /www

# expose ports 80 and 443
EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD["/usr/local/sbin/nginx_config_setup.sh"]
