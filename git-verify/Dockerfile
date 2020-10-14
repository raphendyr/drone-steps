# syntax = docker/dockerfile:1.0-experimental
FROM alpine/git:latest

ENV MAINTAINER_KEYS_BASE=
ENV MAINTAINER_KEYS_EXT=.asc
ENV MAINTAINER_KEYS_HOME=/dev/shm/gnupg-maintainers
ENV MAINTAINER_KEYS=

RUN apk add --no-cache \
    gnupg \
 && :

COPY bin/* /usr/bin/

ENTRYPOINT [ "/usr/bin/init.sh" ]
CMD [ "git-verify" ]
