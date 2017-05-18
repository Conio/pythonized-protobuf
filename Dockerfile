FROM python:3.5-alpine

MAINTAINER "Mirko Bonasorte"
LABEL project="squadrone/pythonized-protobuf"
LABEL version = "3.1.0"
LABEL author="Mirko Bonasorte"
LABEL author_email="mirko@conio.com"

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

#cleanup apk cache
RUN rm -rf /var/cache/apk/*
