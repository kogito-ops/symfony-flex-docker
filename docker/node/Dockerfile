# vim:set ft=dockerfile:

FROM node:12.18.2-alpine3.11
LABEL maintainer="Kogito UG <hello@kogito.network>"

COPY docker/node/docker-entrypoint.sh /usr/local/bin/docker-node-entrypoint
RUN chmod +x /usr/local/bin/docker-node-entrypoint

WORKDIR /srv/app
ENTRYPOINT ["docker-node-entrypoint"]
CMD ["yarn"]

# Copy app into container
COPY . .

# RUN mkdir -p public/build \
#     && yarn install \
#     && yarn build
