FROM debian:buster-slim

# set version label
ARG BUILD_DATE=11042020
ARG VERSION=V1.0
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# install nginx
RUN apt-get update \
	&& apt-get install -y nginx \
	&& echo "*** CONFIGURE NGINX ***" \
	&& rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d /etc/nginx/sites-available /etc/nginx/fastcgi_params /etc/nginx/fastcgi.conf \
	&& apt-get clean

VOLUME /config /www

# copy local directories and files
COPY root/ /

RUN chmod +x /usr/local/bin/nginx_config_setup.sh \
	&& ln -sf /usr/local/bin/nginx_config_setup.sh /

# expose ports 80 and 443
EXPOSE 80 443

STOPSIGNAL SIGTERM

ENTRYPOINT ["nginx_config_setup.sh"]
