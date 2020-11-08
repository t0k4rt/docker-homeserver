FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION

LABEL build_version="Snapcast version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
	curl
RUN \
 echo "**** install snapcast *****" && \
 curl -L https://github.com/badaix/snapcast/releases/download/v${VERSION}/snapserver_${VERSION}-1_amd64.deb -o ./snapserver_${VERSION}_amd64.deb

RUN \
 apt install -y ./snapserver_${VERSION}_amd64.deb && \
 echo "**** cleanup ****" && \
 rm -rf \
	./snapserver_${VERSION}_amd64.deb \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY docker_images/snapcast-server/root / 

# ports and volumes
EXPOSE 1704 1705 1780
VOLUME /config
VOLUME /data