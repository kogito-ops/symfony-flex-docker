# vim:set ft=dockerfile:

FROM alpine:3.11
LABEL maintainer="Kogito UG <hello@kogito.network>"

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.11
ENV GOSU_ARCH amd64
RUN set -ex; \
    \
    apk add --no-cache --virtual .fetch-deps \
    ca-certificates \
    gnupg \
    wget; \
    \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCH}"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCH}.asc"; \
    \
    # verify the signature
    export GNUPGHOME="$(mktemp -d)"; \
    for key in \
    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    ; do \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    gpgconf --kill all; \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    \
    chmod +x /usr/local/bin/gosu; \
    # verify that the binary works
    gosu --version; \
    gosu nobody true; \
    \
    apk del .fetch-deps

# create directory for database bootstrapping
RUN mkdir /docker-entrypoint-initdb.d

# install "pwgen" for randomizing passwords
RUN apk add --no-cache --virtual .persistent-deps \
    pwgen

# install MariaDB
ENV MARIADB_VERSION 10.4.15-r0
RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
    bash \
    tzdata \
    mariadb=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION}

# fix up configuration and data directory
RUN \
    # make room for dymanic configuration files
    mkdir -p /etc/my.cnf.d/ \
    # purge and re-create /var/lib/mysql with appropriate ownership
    && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    # ensure that /run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
    && chmod 777 /run/mysqld \
    # comment out a few problematic configuration values
    && find /etc/my.cnf.d/ -name '*.cnf' -print0 \
    | xargs -rt -0 sed -Ei 's/^(bind-address|log)/#&/' \
    # don't reverse lookup hostnames, they are usually another container
    && echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/my.cnf.d/docker.cnf

VOLUME /var/lib/mysql

COPY docker/mariadb/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
