# vim:set ft=dockerfile:

FROM docker.io/library/alpine:3.13
LABEL maintainer="Kogito UG <hello@kogito.network>"

# Install MailHog:
ENV MAILHOG_VERSION 1.0.1
ENV MAILHOG_ARCH amd64

RUN set -ex; \
    \
    apk add --no-cache --virtual .fetch-deps \
    ca-certificates \
    gnupg \
    wget; \
    \
    wget -O /usr/local/bin/MailHog "https://github.com/mailhog/MailHog/releases/download/v${MAILHOG_VERSION}/MailHog_linux_${MAILHOG_ARCH}"; \
    \
    chmod +x /usr/local/bin/MailHog; \
    \
    apk del .fetch-deps

# Add mailhog user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN adduser -D -u 1000 mailhog

USER mailhog

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025
