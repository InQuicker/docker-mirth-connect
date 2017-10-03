FROM openjdk:jre-alpine

ENV MIRTH_CONNECT_VERSION 3.5.1.b194
COPY ./pkg /tmp

# Mirth Connect is run with user `connect`, uid = 1000
RUN adduser -S mirth -u 1000

RUN apk add gosu \
      --update-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
      --allow-untrusted

RUN apk add vault \
      --update-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
      --allow-untrusted

VOLUME /opt/mirth-connect/appdata

RUN cd /tmp \
      && tar xvzf mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz \
      && rm -f mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz \
      && mv Mirth\ Connect/* /opt/mirth-connect/ \
      && chown -R mirth /opt/mirth-connect

WORKDIR /opt/mirth-connect

EXPOSE 4000

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["java", "-jar", "mirth-server-launcher.jar"]
