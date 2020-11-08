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

RUN install_packages pulseaudio pulseaudio-module-bluetooth xxd alsa-utils

# For local development
#dev-cmd-live=pulseaudio || balena-idle

# PulseAudio configuration
COPY pulseaudio/primitive.pa /etc/pulse/primitive.pa
COPY pulseaudio/client.conf /etc/pulse/client.conf
COPY pulseaudio/daemon.conf /etc/pulse/daemon.conf
COPY usr/docker-pulseaudio-sound.pa.tpl /usr/src/docker-pulseaudio-sound.pa.tpl

# UDev configuration
# COPY udev/95-balena-audio.rules /etc/udev/rules.d/95-balena-audio.rules

# Entrypoint
COPY entry.sh .

ENTRYPOINT [ "/bin/bash", "/usr/src/entry.sh" ]
CMD [ "pulseaudio" ]