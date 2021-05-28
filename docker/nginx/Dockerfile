# vim:set ft=dockerfile:

FROM nginx:1.20.1-alpine
LABEL maintainer="Kogito UG <hello@kogito.network>"

WORKDIR /srv/app

COPY docker/nginx/conf.d /etc/nginx/conf.d/
COPY public /srv/app/public/

EXPOSE 80
EXPOSE 443
