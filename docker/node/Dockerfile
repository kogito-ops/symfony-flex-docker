# vim:set ft=dockerfile:

FROM docker.io/library/node:14.17.0-alpine3.13
LABEL maintainer="Kogito UG <hello@kogito.network>"

COPY docker/node/docker-entrypoint.sh /usr/local/bin/docker-node-entrypoint
RUN chmod +x /usr/local/bin/docker-node-entrypoint

WORKDIR /srv/app
ENTRYPOINT ["docker-node-entrypoint"]
CMD ["npm"]

# Copy app into container
COPY . .
