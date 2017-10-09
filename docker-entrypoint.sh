#!/bin/sh

set -e

if [ "$1" = 'java' ]; then
  [ -x /docker-mirth-preexec.sh ] && /docker-mirth-preexec.sh
  [ -x /docker-mirth-exec.sh ] && /docker-mirth-exec.sh "$@"
  [ -x /docker-mirth-postexec.sh ] && /docker-mirth-postexec.sh

  exec traefik
else
  exec "$@"
fi
