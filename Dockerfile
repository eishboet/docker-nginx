FROM debian:buster-slim

RUN apt-get update \
  && apg-get install -y nginx
