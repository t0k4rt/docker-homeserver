FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION=0.0.1

LABEL build_version="Snapcast version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"
WORKDIR /usr/src

# Required to autodetect ALSA devices
ENV UDEV=on
ENV MODE="MULTI_ROOM"

# DBUS is required for module-bluetooth-discover
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

RUN apt update && apt install -y pulseaudio xxd alsa-utils
RUN  echo "**** cleanup ****" && \
    rm -rf \
	./snapserver_${SNAPCAST_RELEASE}_amd64.deb \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# For local development
#dev-cmd-live=pulseaudio || balena-idle

# PulseAudio configuration
COPY pulse/primitive.pa /etc/pulse/primitive.pa
COPY pulse/client.conf /etc/pulse/client.conf
COPY pulse/daemon.conf /etc/pulse/daemon.conf
COPY usr/docker-pulseaudio-sound.pa.tpl /usr/src/docker-pulseaudio-sound.pa.tpl

# UDev configuration
# COPY udev/95-balena-audio.rules /etc/udev/rules.d/95-balena-audio.rules

# Entrypoint
COPY entry.sh .

ENTRYPOINT [ "/bin/bash", "/usr/src/entry.sh" ]
CMD [ "pulseaudio" ]