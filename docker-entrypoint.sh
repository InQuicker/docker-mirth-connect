#! /bin/bash

set -e

if [ "$1" = 'java' ]; then
    chown -R mirth /opt/mirth-connect/appdata

    su -c mirth "$@"
fi

exec "$@"
