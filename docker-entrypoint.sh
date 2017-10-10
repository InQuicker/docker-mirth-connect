#!/bin/sh

set -e

if [ "$1" = 'java' ]; then
  traefik &

  # Wait for Traefik to start before starting backend
  while ! traefik healthcheck; do
    sleep 0.5
  done

  [ -x /docker-mirth-preexec.sh ] && /docker-mirth-preexec.sh
  [ -x /docker-mirth-exec.sh ] && /docker-mirth-exec.sh "$@"

  # Wait for Mirth to start before running postexec
  while ! curl -s http://localhost:3000/api/server/version; do
    sleep 0.5
  done

  [ -x /docker-mirth-postexec.sh ] && /docker-mirth-postexec.sh

  # Exit if Traefik becomes unresponsive
  while traefik healthcheck; do
    sleep 60
  done
else
  exec "$@"
fi
