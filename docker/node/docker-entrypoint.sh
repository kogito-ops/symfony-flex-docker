#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- yarn "$@"
fi

if [ "$1" = 'yarn' ]; then
    # The first time volumes are mounted, the project needs to be recreated
    if [ ! -f package.json ]; then
        # Create a blank project
		yarn init -yp
    elif [ "$APP_ENV" != 'prod' ]; then
        # Always try to reinstall deps when not in prod
        yarn install
    fi
fi

exec "$@"
