FROM nginx:latest

RUN addgroup -g 1000 -S www-data
RUN adduser -u 1000 -S -G www-data www-data

RUN touch /var/run/nginx.pid \
  && chown -Rf www-data:www-data \
  /var/run/nginx.pid \
  /var/cache/nginx \
  /var/log/nginx

USER www-data
