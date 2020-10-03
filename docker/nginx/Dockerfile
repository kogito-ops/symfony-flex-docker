# vim:set ft=dockerfile:

FROM nginx:1.19.2-alpine
LABEL maintainer="Kogito UG <hello@kogito.network>"

WORKDIR /srv/app

COPY docker/nginx/conf.d /etc/nginx/conf.d/
COPY public /srv/app/public/

EXPOSE 80
EXPOSE 443
