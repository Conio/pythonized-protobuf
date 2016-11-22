FROM python:3.5-alpine

MAINTAINER "Luca Zecca"
LABEL project="lzecca78/pythonized-protobuf"
LABEL version = "3.1.0"
LABEL author="Luca Zecca"
LABEL author_email="l.zecca78@gmail.com"

#compile protobuf bins
ENV PROTOBUF_VERSION=3.1.0

RUN apk add --no-cache build-base curl automake autoconf libtool git zlib-dev && rm -rf /var/cache/apk/* && \
    curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar xvz && \
    cd /protobuf-${PROTOBUF_VERSION} && \
        autoreconf -f -i -Wall && \
        rm -rf autom4te.cache config.h.in~ && \
        ./configure --prefix=/usr --enable-static=no && \
        make && make install && \
        rm -rf `pwd`

#cleanup no more useful packages and apk cache
RUN apk del build-base git automake autoconf
RUN rm -rf /var/cache/apk/*
