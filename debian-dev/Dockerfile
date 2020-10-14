# s_yntax = docker/dockerfile:1.0-experimental
FROM debian:buster-slim

ENV DEBSIGN_KEY=
ENV DEBSIGN_EXPORT_KEY_FILE=

COPY sbin/* /usr/local/sbin

RUN apt-install \
    debhelper \
    devscripts \
 && :

COPY bin/* /usr/local/bin

ENTRYPOINT [ "/usr/bin/init.sh" ]
CMD [ "/bin/bash" ]
