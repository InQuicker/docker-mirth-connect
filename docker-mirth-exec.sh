#!/bin/sh

echo "Mirth starting..."

chown -R mirth /opt/mirth-connect/appdata

gosu mirth "$@" &
