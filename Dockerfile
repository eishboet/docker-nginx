FROM eishboet/debian

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# modify S6 behaviour
ENV S^_BEHAVIOUR_IF_STAGE2_FAILS=2

# install nginx

RUN apt-get update && \
	apt-get install -y nginx && \
	echo "CONFIGURE NGINX" && \
	rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d /etc/nginx/sites-available  


FROM nginx:latest

RUN addgroup -g 1000 -S www-data
RUN adduser -u 1000 -S -G www-data www-data

RUN touch /var/run/nginx.pid \
  && chown -Rf www-data:www-data \
  /var/run/nginx.pid \
  /var/cache/nginx \
  /var/log/nginx

USER www-data
