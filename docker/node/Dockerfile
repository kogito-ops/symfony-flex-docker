# vim:set ft=dockerfile:

FROM node:8.11.1-alpine
LABEL maintainer="Kogito UG <brainz@kogitoapp.com>"

COPY docker/node/docker-entrypoint.sh /usr/local/bin/docker-node-entrypoint
RUN chmod +x /usr/local/bin/docker-node-entrypoint

WORKDIR /srv/app
ENTRYPOINT ["docker-node-entrypoint"]
CMD ["yarn"]
