#!/bin/sh

set -e

traefik &

if [ "$1" = 'java' ]; then
  [ -x /docker-mirth-preexec.sh ] && /docker-preexec.sh
  [ -x /docker-mirth-exec.sh ] && /docker-mirth-exec.sh
  [ -x /docker-mirth-postexec.sh ] && ./docker-mirth-postexec.sh
fi

exec "$@"
