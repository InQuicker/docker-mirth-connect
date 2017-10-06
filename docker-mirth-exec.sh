chown -R mirth /opt/mirth-connect/appdata

gosu mirth "$@" &
