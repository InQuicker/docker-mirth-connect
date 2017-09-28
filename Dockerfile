FROM openjdk:jre-alpine

ENV MIRTH_CONNECT_VERSION 3.5.1.b194
COPY ./pkg /tmp

# Mirth Connect is run with user `connect`, uid = 1000
RUN adduser -S mirth -u 1000

VOLUME /opt/mirth-connect/appdata

RUN cd /tmp \
 			&& tar xvzf mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz \
			&& rm -f mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz \
			&& mv Mirth\ Connect/* /opt/mirth-connect/ \
  		&& chown -R mirth /opt/mirth-connect

WORKDIR /opt/mirth-connect

EXPOSE 8080 8443

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["java", "-jar", "mirth-server-launcher.jar"]
