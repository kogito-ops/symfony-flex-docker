# vim:set ft=dockerfile:

FROM nginx:1.15.7-alpine
LABEL maintainer="Kogito UG <brainz@kogitoapp.com>"

WORKDIR /srv/app

COPY docker/nginx/conf.d /etc/nginx/conf.d/
COPY public /srv/app/public/

EXPOSE 80
EXPOSE 443
