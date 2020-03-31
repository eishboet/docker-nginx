FROM eishboet/debian

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# modify S6 behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# create user
RUN groupmod -g 1000 users && \
	useradd -u 911 -U -d /config -s /bin/false abc && \
	usermod -G users abc && \
	mkdir -p /config

# install nginx

RUN apt-get update && \
	apt-get install -y nginx && \
	echo "CONFIGURE NGINX" && \
	rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d /etc/nginx/sites-available
