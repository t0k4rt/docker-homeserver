FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION=0.0.1
ARG SNAPCAST_RELEASE=0.25.0

LABEL build_version="Snapcast client version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
	curl \
	dbus \
	avahi

RUN \
 echo "**** install snapcast *****" && \
 curl -L https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_RELEASE}/snapclient_${SNAPCAST_RELEASE}-1_amd64.deb -o ./snapclient_${SNAPCAST_RELEASE}_amd64.deb

RUN \
 apt install -y ./snapclient_${SNAPCAST_RELEASE}_amd64.deb && \
 echo "**** cleanup ****" && \
 rm -rf \
	./snapserver_${SNAPCAST_RELEASE}_amd64.deb \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY docker_images/snapcast-client/root / 

# ports and volumes
VOLUME /config
VOLUME /data