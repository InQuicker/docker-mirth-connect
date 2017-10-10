#!/bin/sh

set -e

if [ "$1" = 'java' ]; then
  [ -x /docker-mirth-preexec.sh ] && /docker-mirth-preexec.sh
  [ -x /docker-mirth-exec.sh ] && /docker-mirth-exec.sh "$@"

  # Wait for Mirth to start before running postexec
  while ! curl -s http://localhost:8080/api/server/version > /dev/null 2>&1; do
    sleep 1
  done

  # Wait an additional interval for Mirth to complete initialization
  sleep 1

  [ -x /docker-mirth-postexec.sh ] && /docker-mirth-postexec.sh

  exec traefik
else
  exec "$@"
fi
