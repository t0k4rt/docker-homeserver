FROM ghcr.io/linuxserver/baseimage-alpine:3.12 AS builder-base

# General Build System:
RUN apk -U add \
        git \
        build-base \
        autoconf \
        automake \
        libtool \
        dbus \
        su-exec \
        pulseaudio-dev \
        libdaemon-dev \
        popt-dev \
        mbedtls-dev \
        soxr-dev \
        avahi-dev \
        libconfig-dev \
        libsndfile-dev \
        mosquitto-dev \
        xmltoman

# ALAC Build System:
FROM builder-base AS builder-alac

RUN 	git clone https://github.com/mikebrady/alac
WORKDIR alac
RUN 	autoreconf -fi
RUN 	./configure
RUN 	make
RUN 	make install

# Shairport Sync Build System:
FROM builder-base AS builder-sps

# This may be modified by the Github Action Workflow.
ARG SHAIRPORT_SYNC_BRANCH=master

COPY 	--from=builder-alac /usr/local/lib/libalac.* /usr/local/lib/
COPY 	--from=builder-alac /usr/local/lib/pkgconfig/alac.pc /usr/local/lib/pkgconfig/alac.pc
COPY 	--from=builder-alac /usr/local/include /usr/local/include

RUN 	git clone https://github.com/mikebrady/shairport-sync
WORKDIR shairport-sync
RUN 	git checkout "$SHAIRPORT_SYNC_BRANCH"
RUN 	autoreconf -fi
RUN 	./configure \
              --with-pa \
              --with-dummy \
              --with-pipe \
              --with-stdout \
              --with-avahi \
              --with-ssl=mbedtls \
              --with-soxr \
              --sysconfdir=/etc \
              --with-dbus-interface \
            #   --with-mpris-interface \
            #   --with-mqtt-client \
              --with-apple-alac \
              --with-convolution
RUN 	make -j $(nproc)
RUN 	make install


# Shairport Sync Runtime System:
FROM ghcr.io/linuxserver/baseimage-alpine:3.12

# Use pulse audio
ENV PULSE_SERVER=tcp:localhost:4317

ENV SHAIRPORT_NAME = "Shairport sync"

RUN apk add \
        pulseaudio \
        dbus \
        popt \
        glib \
        mbedtls \
        soxr \
        avahi-daemon \
        libconfig \
        libsndfile \
        mosquitto-libs \
        su-exec \
        libgcc \
        libgc++

RUN 	rm -rf  /lib/apk/db/*

COPY 	--from=builder-alac /usr/local/lib/libalac.* /usr/local/lib/
COPY 	--from=builder-sps /etc/shairport-sync* /etc/
COPY 	--from=builder-sps /etc/dbus-1/system.d/shairport-sync-dbus.conf /etc/dbus-1/system.d/
# COPY 	--from=builder-sps /etc/dbus-1/system.d/shairport-sync-mpris.conf /etc/dbus-1/system.d/
COPY 	--from=builder-sps /usr/local/bin/shairport-sync /usr/local/bin/shairport-sync
# add local files
COPY docker_images/shairport-sync/root/ /

# COPY 	start.sh /
# ENTRYPOINT [ "/start.sh" ]

