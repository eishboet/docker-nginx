FROM eishboet/debian

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="nomad version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Deanen Perumal"

# modify S6 behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# install nginx
RUN apt-get update \
	&& apt-get install -y nginx \
	&& echo "*** CONFIGURE NGINX ***" \
	&& rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf /etc/nginx/sites-available \

# copy local directories and files
COPY root/ /

# expose ports 80 and 443
EXPOSE 80 443
VOLUME /config
VOLUME /www
