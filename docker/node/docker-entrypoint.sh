#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- npm "$@"
fi

if [ "$1" = 'npm' ]; then
    # The first time volumes are mounted, the project needs to be recreated
    if [ ! -f package.json ]; then
        # Create a blank project
		npm init -yf
    else
        # Always try to reinstall deps
        npm install
    fi
fi

exec "$@"
