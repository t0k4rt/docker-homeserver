FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION=1.0.0
ARG LIBRESPOT_RELEASE=v0.1.3

LABEL build_version="Librespot version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"

ENV PULSE_SERVER=tcp:localhost:4317
# COPY docker_images/pulseaudio/alsa_bridge_debian.sh /alsa_bridge_debian.sh
# RUN chmod +x /alsa_bridge_debian.sh && /alsa_bridge_debian.sh && rm /alsa_bridge_debian.sh

RUN \
 echo "**** install packages ****" && \
 apt-get update
 RUN apt-get install -y build-essential libpulse-dev libasound2-dev git pkg-config

# Install rust toolchain
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN git clone https://github.com/librespot-org/librespot && cd /librespot && git checkout ${LIBRESPOT_RELEASE} &&\
	/root/.cargo/bin/cargo build --release --no-default-features --features pulseaudio-backend && \
	cp ./target/release/librespot /usr/bin/librespot

RUN \
 	echo "**** cleanup ****" && \
	apt-get purge -y build-essential git && \
	apt autoremove -y && \
	apt autoclean -y && \
 	rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

# add local files
COPY docker_images/librespot/root / 
