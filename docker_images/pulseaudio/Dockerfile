FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION=0.0.1

LABEL build_version="Pulseaudio server version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"
WORKDIR /usr/src

# Required to autodetect ALSA devices
# ENV UDEV=on
ENV MODE="MULTI_ROOM"

# DBUS is required for module-bluetooth-discover
# ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

RUN apt update && apt install -y pulseaudio xxd alsa-utils

RUN apt autoremove && apt autoclean

RUN  echo "**** cleanup ****" && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# For local development
#dev-cmd-live=pulseaudio || balena-idle
# UDev configuration
# COPY udev/95-balena-audio.rules /etc/udev/rules.d/95-balena-audio.rules

# add local files
COPY docker_images/pulseaudio/root / 

# EXPOSE Pulseaudio port
EXPOSE 4317

# WORKDIR /usr/src

# Entrypoint
COPY docker_images/pulseaudio/entry.sh /usr/src/entry.sh

# RUN ls -l /usr/src
# ENTRYPOINT [ "/bin/bash", "/usr/src/entry.sh" ]
# CMD [ "pulseaudio", "--file", "/etc/pulse/docker-pa-server.pa" ]