FROM misotolar/alpine:3.21.3

LABEL maintainer="michal@sotolar.com"

ENV ASTERISK_VERSION=20.11.1
ARG ASTERISK_REV=0

ENV ASTERISK_USER_UID=1000
ENV ASTERISK_GROUP_GID=1000

RUN set -ex; \
    apk add --no-cache \
        asterisk \
        asterisk-odbc \
        asterisk-sample-config \
        mariadb-connector-odbc \
    ; \
    asterisk -U asterisk; \
    sleep 5; \
    pkill -9 asterisk; \
    pkill -9 astcanary; \
    sleep 2; \
    truncate -s 0 /var/log/asterisk/messages /var/log/asterisk/queue_log; \
    rm -rf \
        /var/run/asterisk/* \
        /var/cache/apk/* \
        /var/tmp/* \
        /tmp/*

COPY resources/etc/odbcinst.ini /etc/odbcinst.ini
COPY resources/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["asterisk", "-T", "-U", "asterisk", "-G", "asterisk", "-f", "-p"]
